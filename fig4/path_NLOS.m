function [ loss ] = path_NLOS( d )
%     d=d/1000;
%     loss=147.4 +43.3*log10(d);   
%     loss=max(15.3 +37.6*log10(d), path_LOS( d ))+20; 
%     loss=max(2.7 +42.8*log10(d), path_LOS( d ))+20;  
    loss=32.6 +36.7*log10(d);
end

