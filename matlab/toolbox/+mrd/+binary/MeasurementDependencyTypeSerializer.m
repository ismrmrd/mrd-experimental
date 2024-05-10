% This file was generated by the "yardl" tool. DO NOT EDIT.

classdef MeasurementDependencyTypeSerializer < yardl.binary.RecordSerializer
  methods
    function self = MeasurementDependencyTypeSerializer()
      field_serializers{1} = yardl.binary.StringSerializer;
      field_serializers{2} = yardl.binary.StringSerializer;
      self@yardl.binary.RecordSerializer('mrd.MeasurementDependencyType', field_serializers);
    end

    function write(self, outstream, value)
      arguments
        self
        outstream (1,1) yardl.binary.CodedOutputStream
        value (1,1) mrd.MeasurementDependencyType
      end
      self.write_(outstream, value.dependency_type, value.measurement_id);
    end

    function value = read(self, instream)
      fields = self.read_(instream);
      value = mrd.MeasurementDependencyType(dependency_type=fields{1}, measurement_id=fields{2});
    end
  end
end
