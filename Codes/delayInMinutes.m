function [delay] = delayInMinutes(ArrDelayMins,tmp)

j = 0;
for i=1:length(ArrDelayMins)
  if ~isequal(ArrDelayMins{i} ,'')
      j= j+1;
      delay(j) = str2num(ArrDelayMins{i});
  end
end
delay = [delay(:);tmp(:)];

