function [B,A] = lsvf(gain, q, fc,fs)
%
%      fc - center frequency (Hz)
%      gain - gain at the peak (dB)
%      q - Q factor
%      fs - sampling frequency (Hz)
%
%   
Q=q./256;
dBgain=(gain-127)./8;
fs=fs(:,1);
omega = (2 * pi * fc) ./ fs;
alpha = sin(omega) ./(2*Q);
a = power(10,dBgain./40); % ^ (dBgain/40);
beta=sqrt(a).*alpha;
A=zeros(1,3); B=zeros(1,3);


BB = [
   a.* ((a + 1) - (a - 1).* cos(omega) + 2.*beta);
   2.* a .* ((a - 1) - (a + 1).* cos(omega));
   a.* ((a + 1) - (a - 1).* cos(omega) - 2.*beta)
]';

AA = [
   (a + 1) + (a - 1).* cos(omega) + 2.*beta;
   -2.* ((a - 1) + (a + 1).* cos(omega));
   (a + 1) + (a - 1).* cos(omega) - 2.*beta
]';

B(1,1)=BB(1,1)./AA(1,1);
B(1,2)=BB(1,2)./AA(1,1);
B(1,3)=BB(1,3)./AA(1,1);

A(1,1)=AA(1,1)./AA(1,1);
A(1,2)=AA(1,2)./AA(1,1);
A(1,3)=AA(1,3)./AA(1,1);

B=[B(1,1) B(1,2) B(1,3)];
A=[A(1,1) A(1,2) A(1,3)];
end
