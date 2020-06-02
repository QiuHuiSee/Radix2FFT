clc;clear;close all;

Fs = 10000; %what is the sampling f should be?
n = 0:1*Fs;
x = sin(2*pi*100*n/Fs);
figure(1);
plot(n,x); 
X = fft(x,256);
Xmag = abs(X);
Xphase = angle(X);
figure(2);
plot(0:255,Xmag); 
title('DFT, |X[k]|'), xlabel('k')
