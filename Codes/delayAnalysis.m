function [mapDelay, mapFlight, mapState, mapFlightState, delay60] = delayAnalysis(mapDelay, mapFlight, mapState, mapFlightState, carr, group, state)

len = length(carr);
delay60 = 0;

for i=1:len
    % Hash table corresponding to flights opertaed by carriers
    % Key: Carriers, Data: number of flights
    if (mapFlight.containsKey(carr{i}))
       mapFlight.put(carr{i}, 1 + mapFlight.get(carr{i}));
    else
        mapFlight.put(carr{i},1);
    end
    
    if (mapFlightState.containsKey(state{i}))
         mapFlightState.put(state{i}, 1 + mapFlightState.get(state{i}));
    else
        mapFlightState.put(state{i},1);
    end
    
    % Hash table corresponding to delays by carriers
    % Key: Carriers, Data: number of delayed flights > 60 mins
    
    % Hash table corresponding to delays by destination states
    % Key: States, Data: number of delayed flights > 60 mins
    if ~isequal(group{i} ,'')
        delay_num = str2num(group{i});
        if (delay_num >= 4) % delay group 4 above, equivalent to more than 60 mins delay
            delay60 = delay60 + 1;
            if mapDelay.containsKey(carr{i})
                mapDelay.put(carr{i}, 1 + mapDelay.get(carr{i}));
            else
                mapDelay.put(carr{i},1);
            end
            
            if mapState.containsKey(state{i})
                mapState.put(state{i}, 1 + mapState.get(state{i}));
            else
                mapState.put(state{i}, 1);
            end
        end
        
    end
    
    
   
end

 

