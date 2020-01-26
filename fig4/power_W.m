function [ power ] = power_W( W )
%     power=sum(sum(abs(W).^2));
    power=real(trace(W'*W));
end

