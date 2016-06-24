%%% Calculates number of delayed (+15 min) flights 
%%% for each month, and ratio of delayed flights over 
%%% total flights (per month).
function [numOfDelayed, ratio] = DelRatio(delay)
len = length(delay);
numOfDelayed = 0;
for i=1:len
   if isequal(delay{i} ,'1.00')
       numOfDelayed = numOfDelayed + 1;
   end
   
end

ratio = numOfDelayed/len;


