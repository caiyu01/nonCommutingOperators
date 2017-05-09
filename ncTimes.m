function out = ncTimes(varargin)
% ncTimes multiplies expression of operators
% format: Op = {1,'a0'; 1/2, 'b1c2'; 2, ''; ...}
% n by 2 cell, first column: coefficient, second column: operator
% assumes a0*a0=Id, as with pauli operators
% operators commute if they carry a different letter
% assumed to be non commuting otherwise
% example: ncTimes({1,'a0'},{1/2,'b0c1';1/2,'a1'})

if length(varargin)>2
    
    out = ncTimes(varargin{1},ncTimes(varargin{2:end}));
    
elseif length(varargin)==2
    
    a = varargin{1};
    b = varargin{2};
    
    out1 = cell(size(a,1)*size(b,1),2);
    kk = 1;
    for ii=1:size(a,1)
        for jj=1:size(b,1)
            
            out1{kk,1} = a{ii,1}*b{jj,1};
            out1{kk,2} = [a{ii,2} b{jj,2}];
            kk = kk+1;
        end
    end
    
    out = simplifyPauli(out1);
    
else
    
    error('check input');
    
end

end