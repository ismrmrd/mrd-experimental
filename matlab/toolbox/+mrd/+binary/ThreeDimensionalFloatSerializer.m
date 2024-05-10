% This file was generated by the "yardl" tool. DO NOT EDIT.

classdef ThreeDimensionalFloatSerializer < yardl.binary.RecordSerializer
  methods
    function self = ThreeDimensionalFloatSerializer()
      field_serializers{1} = yardl.binary.Float32Serializer;
      field_serializers{2} = yardl.binary.Float32Serializer;
      field_serializers{3} = yardl.binary.Float32Serializer;
      self@yardl.binary.RecordSerializer('mrd.ThreeDimensionalFloat', field_serializers);
    end

    function write(self, outstream, value)
      arguments
        self
        outstream (1,1) yardl.binary.CodedOutputStream
        value (1,1) mrd.ThreeDimensionalFloat
      end
      self.write_(outstream, value.x, value.y, value.z);
    end

    function value = read(self, instream)
      fields = self.read_(instream);
      value = mrd.ThreeDimensionalFloat(x=fields{1}, y=fields{2}, z=fields{3});
    end
  end
end
