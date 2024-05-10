% This file was generated by the "yardl" tool. DO NOT EDIT.

classdef UserParameterLongType < handle
  properties
    name
    value
  end

  methods
    function self = UserParameterLongType(kwargs)
      arguments
        kwargs.name = "";
        kwargs.value = int64(0);
      end
      self.name = kwargs.name;
      self.value = kwargs.value;
    end

    function res = eq(self, other)
      res = ...
        isa(other, "mrd.UserParameterLongType") && ...
        all([self.name] == [other.name]) && ...
        all([self.value] == [other.value]);
    end

    function res = ne(self, other)
      res = ~self.eq(other);
    end
  end

  methods (Static)
    function z = zeros(varargin)
      elem = mrd.UserParameterLongType();
      if nargin == 0
        z = elem;
        return;
      end
      sz = [varargin{:}];
      if isscalar(sz)
        sz = [sz, sz];
      end
      z = reshape(repelem(elem, prod(sz)), sz);
    end
  end
end
