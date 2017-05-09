function out = ncPlus(varargin)

if length(varargin)>2
    
    out = ncPlus(varargin{1},ncPlus(varargin{2:end}));
    
elseif length(varargin)==2
    
    a = varargin{1};
    b = varargin{2};
    
    out = simplifyPauli([a;b]);
    
else
    
    error('check input')
    
end