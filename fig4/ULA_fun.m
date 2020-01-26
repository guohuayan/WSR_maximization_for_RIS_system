function [ h ] = ULA_fun( phi ,N)
    h=exp(1j*pi*sin(phi).*(0:N-1)');
end

