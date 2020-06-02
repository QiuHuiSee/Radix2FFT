clc;clear;close all;
Fs=256;
N = 256;
f=10; %Frequency of sinusoid
t=0:1/Fs:(N-1)/Fs; %time index
S=cos(2*pi*f*t);
 
plot(t,S)
title('Continuous sinusoidal signal');
xlabel('Time(s)');
ylabel('Amplitude');

%% Spectrum of X
kshift = -(256-1)/2:(256-1)/2; 
X = fftshift(fft(S,256)); % Do DFT, X[k] 
Xmag = abs(X); Xphase = angle(X);
F = Fs*kshift/256; W = 2*pi*Fs*kshift/256; % Frequency Conversion 

X = fft(S,256); % Do DFT
Xmag = abs(X); Xphase = angle(X);

figure(2);
subplot(2,1,1);
plot(0:255,Xmag), xlabel('F(Hz)'), ylabel('|X(F)|')
title('Spectrum of Signal in Magnitude Response'), grid on

subplot(2,1,2);
plot(0:255,Xphase),xlabel('F(Hz)'), ylabel('\angle X(F)') 
title('Spectrum of Signal in Phase Response'), grid on

%%
% kshift = -(N-1)/2:(N-1)/2; 
% X = fftshift(fft(S,N)); % Do DFT, X[k] 
% Xmag = abs(X); Xphase = angle(X);
% F = Fs*kshift/N; W = 2*pi*Fs*kshift/N; % Frequency Conversion 
% 
% figure(2);
% subplot(2,1,1);
% plot(F,Xmag), xlabel('F(Hz)'), ylabel('|X(F)|')
% title('Frequency Spectrum in Magnitude Response'), grid on
% xlim([-300 300]);
% 
% subplot(2,1,2);
% plot(F,Xphase),xlabel('F(Hz)'), ylabel('\angle X(F)') 
% title('Frequency Spectrum in Phase Response'), grid on
%%
k=1;
for i = 1:length(Xmag(1,:))
    if Xmag(1,i) > 1.0
        j(k)=i;
        k=k+1;
    end
end

Xmag_prime = Xmag';
S_prime = S';
X_prime = X';