function varargout = setStateName(obj,varargin)
    nVarargs = length(varargin);
    name = varargin{1};
    if nVarargs == 2
        index = varargin{2};
    else
        index = 1:obj.dim.x;
    end
    varargout = cell(size(index));
    j = 1;
    for i=index
        obj.x(i) = sym(name{j});
        varargout{j} = sym(name{j});
        j = j+1;
    end
end