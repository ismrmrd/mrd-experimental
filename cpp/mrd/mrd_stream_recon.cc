#include "generated/binary/protocols.h"
#include "generated/protocols.h"
#include "generated/types.h"
#include <xtensor-fftw/basic.hpp>
#include <xtensor-fftw/helper.hpp>
#include <xtensor/xstrided_view.hpp>
#include <xtensor/xview.hpp>

xt::xtensor<std::complex<float>, 4> fftshift(xt::xtensor<std::complex<float>, 4> x) {
  return xt::roll(xt::roll(x, x.shape(3) / 2, 3), x.shape(2) / 2, 2);
}

int main() {
  mrd::binary::MrdReader r(std::cin);
  mrd::binary::MrdWriter w(std::cout);

  mrd::Header h;
  r.ReadHeader(h);

  // Just copy the header
  w.WriteHeader(h);

  // When we have aliased types, we will use that.
  mrd::StreamItem v;
  xt::xtensor<std::complex<float>, 4> buffer;
  while (r.ReadData(v)) {
    if (std::holds_alternative<mrd::Acquisition>(v)) {
      auto a = std::get<mrd::Acquisition>(v);
      // if this is the first line, we need to allocate the buffer
      if (std::find(a.flags.begin(), a.flags.end(), mrd::AcquisitionFlags::kFirstInEncodeStep1) != a.flags.end()) {
        std::array<size_t, 4> shape = {a.data.shape()[0], h.encoding[0].recon.matrix_size[0], h.encoding[0].recon.matrix_size[1], h.encoding[0].recon.matrix_size[2]};
        buffer = xt::zeros<std::complex<float>>(shape);
      }

      // Remove oversampling
      if (a.Samples() > h.encoding[0].recon.matrix_size[2]) {
        auto new_shape = a.data.shape();
        new_shape[1] = h.encoding[0].recon.matrix_size[2];
        auto x_pad = (a.data.shape()[1] - h.encoding[0].recon.matrix_size[2]) / 2;
        xt::xtensor<std::complex<float>, 2> new_data = xt::zeros<std::complex<float>>(new_shape);
        for (size_t c = 0; c < a.Coils(); c++) {
          auto ft_line = xt::xarray<std::complex<float>>(xt::view(a.data, c, xt::all()));
          ft_line = xt::fftw::fftshift(xt::fftw::ifft(xt::fftw::ifftshift(ft_line)));
          ft_line = xt::view(ft_line, xt::range(x_pad, h.encoding[0].recon.matrix_size[2] + x_pad));
          ft_line = xt::fftw::fftshift(xt::fftw::fft(xt::fftw::ifftshift(ft_line)));
          xt::view(new_data, c, xt::all()) = ft_line;
        }
        a.data = new_data;
      }

      // copy the data into the buffer
      xt::view(buffer, xt::all(), a.idx.e2.value(), a.idx.e1.value(), xt::all()) = xt::xarray<std::complex<float>>(a.data);

      // if this is the last line, we need to write the buffer
      if (std::find(a.flags.begin(), a.flags.end(), mrd::AcquisitionFlags::kLastInEncodeStep1) != a.flags.end()) {
        buffer = fftshift(buffer);
        for (unsigned int c = 0; c < buffer.shape()[0]; c++) {
          auto tmp1 = xt::fftw::ifft2(xt::xarray<std::complex<float>>(xt::view(buffer, c, 0, xt::all(), xt::all())));
          xt::view(buffer, c, 0, xt::all(), xt::all()) = tmp1;
        }
        buffer = fftshift(buffer);

        std::array<size_t, 4> image_shape = {1, buffer.shape()[1], buffer.shape()[2], buffer.shape()[3]};
        auto pixel_data = xt::sqrt(xt::abs(xt::sum(buffer * xt::conj(buffer), 0)));
        mrd::Image<float> im;
        im.data = xt::zeros<float>(image_shape);
        xt::view(im.data, 0, xt::all(), xt::all(), xt::all()) = pixel_data;
        w.WriteData(im);
      }
    }
  }

  w.EndData();

  return 0;
}
