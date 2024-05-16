% This file was generated by the "yardl" tool. DO NOT EDIT.

classdef Image < handle
  properties
    flags
    measurement_uid
    field_of_view
    position
    col_dir
    line_dir
    slice_dir
    patient_table_position
    average
    slice
    contrast
    phase
    repetition
    set
    acquisition_time_stamp
    physiology_time_stamp
    image_type
    image_index
    image_series_index
    user_int
    user_float
    data
    meta
  end

  methods
    function self = Image(kwargs)
      arguments
        kwargs.flags = mrd.ImageFlags(0);
        kwargs.measurement_uid = uint32(0);
        kwargs.field_of_view = repelem(single(0), 3, 1);
        kwargs.position = repelem(single(0), 3, 1);
        kwargs.col_dir = repelem(single(0), 3, 1);
        kwargs.line_dir = repelem(single(0), 3, 1);
        kwargs.slice_dir = repelem(single(0), 3, 1);
        kwargs.patient_table_position = repelem(single(0), 3, 1);
        kwargs.average = yardl.None;
        kwargs.slice = yardl.None;
        kwargs.contrast = yardl.None;
        kwargs.phase = yardl.None;
        kwargs.repetition = yardl.None;
        kwargs.set = yardl.None;
        kwargs.acquisition_time_stamp = yardl.None;
        kwargs.physiology_time_stamp = uint32.empty();
        kwargs.image_type;
        kwargs.image_index = yardl.None;
        kwargs.image_series_index = yardl.None;
        kwargs.user_int = int32.empty();
        kwargs.user_float = single.empty();
        kwargs.data;
        kwargs.meta = dictionary;
      end
      self.flags = kwargs.flags;
      self.measurement_uid = kwargs.measurement_uid;
      self.field_of_view = kwargs.field_of_view;
      self.position = kwargs.position;
      self.col_dir = kwargs.col_dir;
      self.line_dir = kwargs.line_dir;
      self.slice_dir = kwargs.slice_dir;
      self.patient_table_position = kwargs.patient_table_position;
      self.average = kwargs.average;
      self.slice = kwargs.slice;
      self.contrast = kwargs.contrast;
      self.phase = kwargs.phase;
      self.repetition = kwargs.repetition;
      self.set = kwargs.set;
      self.acquisition_time_stamp = kwargs.acquisition_time_stamp;
      self.physiology_time_stamp = kwargs.physiology_time_stamp;
      if ~isfield(kwargs, "image_type")
        throw(yardl.TypeError("Missing required keyword argument 'image_type'"))
      end
      self.image_type = kwargs.image_type;
      self.image_index = kwargs.image_index;
      self.image_series_index = kwargs.image_series_index;
      self.user_int = kwargs.user_int;
      self.user_float = kwargs.user_float;
      if ~isfield(kwargs, "data")
        throw(yardl.TypeError("Missing required keyword argument 'data'"))
      end
      self.data = kwargs.data;
      self.meta = kwargs.meta;
    end

    function res = channels(self)
      res = size(self.data, ndims(self.data)-(0));
      return
    end

    function res = slices(self)
      res = size(self.data, ndims(self.data)-(1));
      return
    end

    function res = rows(self)
      res = size(self.data, ndims(self.data)-(2));
      return
    end

    function res = cols(self)
      res = size(self.data, ndims(self.data)-(3));
      return
    end


    function res = eq(self, other)
      res = ...
        isa(other, "mrd.Image") && ...
        isequal(self.flags, other.flags) && ...
        isequal(self.measurement_uid, other.measurement_uid) && ...
        isequal(self.field_of_view, other.field_of_view) && ...
        isequal(self.position, other.position) && ...
        isequal(self.col_dir, other.col_dir) && ...
        isequal(self.line_dir, other.line_dir) && ...
        isequal(self.slice_dir, other.slice_dir) && ...
        isequal(self.patient_table_position, other.patient_table_position) && ...
        isequal(self.average, other.average) && ...
        isequal(self.slice, other.slice) && ...
        isequal(self.contrast, other.contrast) && ...
        isequal(self.phase, other.phase) && ...
        isequal(self.repetition, other.repetition) && ...
        isequal(self.set, other.set) && ...
        isequal(self.acquisition_time_stamp, other.acquisition_time_stamp) && ...
        isequal(self.physiology_time_stamp, other.physiology_time_stamp) && ...
        isequal(self.image_type, other.image_type) && ...
        isequal(self.image_index, other.image_index) && ...
        isequal(self.image_series_index, other.image_series_index) && ...
        isequal(self.user_int, other.user_int) && ...
        isequal(self.user_float, other.user_float) && ...
        isequal(self.data, other.data) && ...
        isequal(self.meta, other.meta);
    end

    function res = ne(self, other)
      res = ~self.eq(other);
    end
  end

end