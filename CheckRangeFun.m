function [ RangeCheck ] = CheckRangeFun( min, max, value )
%Returns 1 if the value is within min and max, returns 0 if value is out of
%bounds
if min<=value && max>=value
    RangeCheck=1;
else
    RangeCheck=0;
end

end

