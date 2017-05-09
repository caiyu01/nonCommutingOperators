function [ out ] = simplifyPauli( in )
% simplifyPauli simplifys an expression of operators
% format: Op = {1,'a0'; 1/2, 'b1c2'; 2, ''; ...}
% n by 2 cell, first column: coefficient, second column: operator
% assumes a0*a0=Id, as with pauli operators

for ii=1:size(in,1);
    
    in{ii,2} = simplifyOpString(in{ii,2});

end

uniqueOp = uniquecell(in(:,2));
out = cell(size(uniqueOp,1),2);

eliminated = [];
for kk=1:size(uniqueOp,1)
    
    out{kk,2} = uniqueOp{kk};
    
    cTemp = 0;
    for jj = 1:size(in,1)
        if strcmp(in{jj,2},out{kk,2})
            cTemp = cTemp+in{jj,1};
        end
    end

    out{kk,1} = cTemp;
    if cTemp==0
        eliminated = [eliminated kk];
    end

end

out(eliminated,:) = [];

end

function out = simplifyOpString(in)
% special case, just a number
% if it contains Id, remove it
in = regexprep(in,'Id','');

if strcmp(in,'') || strcmp(in,'Id')
    out = 'Id';
    return
end

% step 1: commute those commuting ones; different parties commute
% get all the alphabet; assume using single letter
letters = [];
for ii = 1:length(in)
    if isnan(str2double(in(ii)))
        letters = [letters, in(ii)];
    end
end

letters = unique(letters);

out1 = [];
for ii = 1:length(letters)
    ind = find(in==letters(ii)); 
    tmp = [];
    for jj = 1:length(ind)
        % assume single digit labels
        tmp = [tmp in([ind(jj) ind(jj)+1])];
    end
    out1 = [out1 tmp];
end


% step2: A1*A1 = 1;
ind = [];
for ii=1:2:length(out1)-3
    if strcmp(out1([ii,ii+1]),out1([ii+2,ii+3]))
        ind = [ind ii];
    end
end

out = out1;
for ii=1:length(ind)
    t = ind(ii);
    tmpStr = out1([t,t+1]);
    out = regexprep(out,[tmpStr tmpStr],'');
end

if strcmp(out,'')
    out = 'Id';
end
end
