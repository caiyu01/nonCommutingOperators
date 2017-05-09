function [ strOut ] = ncDisp( in )
% to display the results of ncTimes
strOut=[];
for ii=1:size(in,1) 
    
    strOut = [strOut sprintf('%+i',in{ii,1}) '*' in{ii,2}];
    
end


end

