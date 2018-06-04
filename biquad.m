function  biquad(data_file,file_name,option)

disp(' ');
disp('################################################');
disp('This is the PEQ biquad filter Simulation Program');
disp('Designed by Philip at 1/3/2017');
disp('Contact : philip.park@esstech.com');
disp('Type biquad [data file] [audio file]');
disp('################################################');

if ~exist('option','var')
    % third parameter does not exist, so default it to no time response
    option=0;
end



%coder.extrinsic('audioread'); 

[audio_file,fs]=audioread(file_name);
Ts=1/fs;

F=logspace(0,log10(1/Ts/2),100);
w=2*pi*F;

fileID=fopen(data_file);
C = textscan(fileID,'%s  %f  %f  %f ');
fclose(fileID);

%NFFT=length(audio_file);
%t=linspace(0,length(audio_file)/fs,length(audio_file));
%plot(t,audio_file);
%f=linspace(0,fs,NFFT);
%G=abs(fft(audio_file,NFFT));
%figure; plot(f(1:NFFT/2),G(1:NFFT/2));

%celldisp(C);
[B1,A1]=flt_type(C{1}{1},1,C,fs);
[m1,p1]=dbode(B1,A1,Ts,w);
[B2,A2]=flt_type(C{1}{2},2,C,fs);
[m2,p2]=dbode(B2,A2,Ts,w);
[B3,A3]=flt_type(C{1}{3},3,C,fs);
[m3,p3]=dbode(B3,A3,Ts,w);
[B4,A4]=flt_type(C{1}{4},4,C,fs);
[m4,p4]=dbode(B4,A4,Ts,w);
[B5,A5]=flt_type(C{1}{5},5,C,fs);
[m5,p5]=dbode(B5,A5,Ts,w);
[B6,A6]=flt_type(C{1}{6},6,C,fs);
[m6,p6]=dbode(B6,A6,Ts,w);
[B7,A7]=flt_type(C{1}{7},7,C,fs);
[m7,p7]=dbode(B7,A7,Ts,w);
[B8,A8]=flt_type(C{1}{8},8,C,fs);
[m8,p8]=dbode(B8,A8,Ts,w);
[B9,A9]=flt_type(C{1}{9},9,C,fs);
[m9,p9]=dbode(B9,A9,Ts,w);
[B10,A10]=flt_type(C{1}{10},10,C,fs);
[m10,p10]=dbode(B10,A10,Ts,w);
[B11,A11]=flt_type(C{1}{11},11,C,fs);
[m11,p11]=dbode(B11,A11,Ts,w);
[B12,A12]=flt_type(C{1}{12},12,C,fs);
[m12,p12]=dbode(B12,A12,Ts,w);
[B13,A13]=flt_type(C{1}{13},13,C,fs);
[m13,p13]=dbode(B13,A13,Ts,w);
[B14,A14]=flt_type(C{1}{14},14,C,fs);
[m14,p14]=dbode(B14,A14,Ts,w);
[B15,A15]=flt_type(C{1}{15},15,C,fs);
[m15,p15]=dbode(B15,A15,Ts,w);
[B16,A16]=flt_type(C{1}{16},16,C,fs);
[m16,p16]=dbode(B16,A16,Ts,w);

disp('Filter starts....');
y=filter(B1,A1,audio_file);
y=filter(B2,A2,y);
y=filter(B3,A3,y);
y=filter(B4,A4,y);
y=filter(B5,A5,y);
y=filter(B6,A6,y);
y=filter(B7,A7,y);
y=filter(B8,A8,y);
y=filter(B9,A9,y);
y=filter(B10,A10,y);
y=filter(B11,A11,y);
y=filter(B12,A12,y);
y=filter(B13,A13,y);
y=filter(B14,A14,y);
y=filter(B15,A15,y);
y=filter(B16,A16,y);

audiowrite('output.wav',y,fs);
%save('output.mat','y','fs');
disp('Write audio file');

p=audioplayer(y, fs);
play(p);

% Syntax: set(gcf,’position’,[a b L W])
%
% (a,b) = is the lower left corner
% L = the horizontal length of the window
% W = the vertical width of the window
%


% Time domain plot
xpos=100; ypos=100;
Length=800; Width=600;

if option == 't'
figure('Position', [xpos+Length, ypos, Length, Width]);
t=0:size(audio_file)-1;
plot(t*Ts,audio_file,t*Ts,y);
legend(file_name,'output.wav');
xlabel('Time (sec)'); ylabel('Magnitude'); title('Actual audio file');
grid;
end
%

figure('Position', [xpos, ypos, Length, Width]);
biplot(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,F,...
     p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15);
legend(C{1}{1},C{1}{2},C{1}{3},C{1}{4},C{1}{5},C{1}{6},C{1}{7},C{1}{8},...
C{1}{9},C{1}{10},C{1}{11},C{1}{12},C{1}{13},C{1}{14},C{1}{15},C{1}{16});
disp('Paused. Please enter the return key');  
pause;
close all;
end

function [B,A]=flt_type(flt_list,count,C,fs)
        switch flt_list
            case 'PEQ',               
                type= 'peq'; gain = C{2}(count,1);  q = C{3}(count,1);  fc = C{4}(count,1);  
                disp(sprintf('[%2d]PEQ [gain,q,fc]= %5d , %5d , %5d',count,gain,q,fc));
                [B,A]=biquad_peak(gain,q,fc,fs);
            case 'GAIN',      
                type= 'gain'; gain = C{2}(count,1); q = C{3}(count,1);  fc = C{4}(count,1);  
                disp(sprintf('[%2d]GAIN [gain,q,fc]= %5d , %5d , %5d',count,gain,q,fc));
                [B,A]=gain_pass(gain,q,fc,fs);
            case 'LSV',
                type= 'lsv'; gain = C{2}(count,1);  q = C{3}(count,1);  fc = C{4}(count,1);  
                disp(sprintf('[%2d]LSV [gain,q,fc]= %5d , %5d , %5d',count,gain,q,fc));
                [B,A]=lsvf(gain,q,fc,fs);
            case 'HSV',
                type= 'hsv'; gain = C{2}(count,1);  q = C{3}(count,1);  fc = C{4}(count,1);  
                disp(sprintf('[%2d]HSV [gain,q,fc]= %5d , %5d , %5d',count,gain,q,fc));
                [B,A]=hsvf(gain,q,fc,fs);
            case 'LPF',
                type= 'lpf'; gain = C{2}(count,1);  q = C{3}(count,1);  fc = C{4}(count,1);  
                disp(sprintf('[%2d]LPF [gain,q,fc]= %5d , %5d , %5d',count,gain,q,fc));
                [B,A]=low_pass(gain,q,fc,fs);
            case 'HPF',
                type= 'hpf'; gain = C{2}(count,1);  q = C{3}(count,1);  fc = C{4}(count,1);  
                disp(sprintf('[%2d]HPF [gain,q,fc]= %5d , %5d , %5d',count,gain,q,fc));
                [B,A]=high_pass(gain,q,fc,fs);
        end 
end 
 
function [B,A] = biquad_peak(gain, q, fc,fs)
%
%      fc - center frequency (Hz)
%      gain - gain at the peak (dB)
%      q - Q factor
%      fs - sampling frequency (Hz)
%
% 
Q=q/256;
dBgain=(gain-127)/8;
fs=fs(:,1);
omega = (2 * pi * fc) ./ fs;
alpha = sin(omega) ./ (2*Q);
a = power(10,dBgain/40); % ^ (dBgain/40);
A=zeros(1,3); B=zeros(1,3);
BB = [
   1 + alpha .* a;
  -2 * cos(omega);
   1 - alpha .* a
]';

AA = [
   1 + alpha ./ a;
  -2 * cos(omega);
   1 - alpha ./ a
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

function [B,A] = gain_pass(gain, q, fc,fs)
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
b = power(10,dBgain./20);
A=zeros(1,3); B=zeros(1,3);
BB = [
    b(:,1);
    0;
    0
]';

AA = [
   1;
   0;
   0
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

function [B,A] = high_pass(gain, q, fc,fs)
%
%      fc - center frequency (Hz)
%      gain - gain at the peak (dB)
%      q - Q factor
%      fs - sampling frequency (Hz)
%
%   
Q=q/256;
dBgain=(gain-127)/8;
fs=fs(:,1);
omega = 2 * pi * fc ./ fs;
alpha = sin(omega) ./ (2*Q);
a = power(10,dBgain/40); % ^ (dBgain/40);
A=zeros(1,3); B=zeros(1,3);
BB = [
   (1 + cos(omega))./2;
   -(1+cos(omega));
   (1 + cos(omega))./2
]';

AA = [
   1 + alpha;
  -2 * cos(omega);
   1 - alpha
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

function [B,A] = hsvf(gain, q, fc,fs)
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
   a.*((a+1)+(a-1).*cos(omega)+2.*beta);
   -2.*a.*((a-1)+(a+1).*cos(omega));
   a.*((a+1)+(a-1).*cos(omega)-2.*beta)
]';

AA = [
   (a + 1) - (a - 1).* cos(omega) + 2.*beta;
   2.* ((a - 1) - (a + 1).* cos(omega));
   (a + 1) - (a - 1).* cos(omega) - 2.*beta
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

function [B,A] = low_pass(gain, q, fc,fs)
%
%      fc - center frequency (Hz)
%      gain - gain at the peak (dB)
%      q - Q factor
%      fs - sampling frequency (Hz)
%
%   
Q=q/256;
dBgain=(gain-127)/8;
fs=fs(:,1);
omega = (2 * pi * fc) ./ fs;
alpha = sin(omega) ./ (2*Q);
a = power(10,dBgain/40); % ^ (dBgain/40);
A=zeros(1,3); B=zeros(1,3);
BB = [
   (1 - cos(omega))./2;
   1-cos(omega);
   (1 - cos(omega))./2
]';

AA = [
   1 + alpha;
  -2 * cos(omega);
   1 - alpha
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

function []=biplot(m1,m2,m3,m4,m5,m6,m7,m8,m9,m10,m11,m12,m13,m14,m15,f,...
    p1,p2,p3,p4,p5,p6,p7,p8,p9,p10,p11,p12,p13,p14,p15)
% Bode plot

m1db = 20*log10(m1);         % dB
m2db = 20*log10(m2); 
m3db = 20*log10(m3); 
m4db = 20*log10(m4); 
m5db = 20*log10(m5); 
m6db = 20*log10(m6); 
m7db = 20*log10(m7); 
m8db = 20*log10(m8); 
m9db = 20*log10(m9); 
m10db = 20*log10(m10); 
m11db = 20*log10(m11); 
m12db = 20*log10(m12); 
m13db = 20*log10(m13); 
m14db = 20*log10(m14);
m15db = 20*log10(m15); 
mdb = m1db+m2db+m3db+m4db+m5db+m6db+m7db+m8db+m9db+m10db+m11db+m12db+m13db+m14db+m15db;
p=p1+p2+p3+p4+p5+p6+p7+p8+p9+p10+p11+p12+p13+p14+p15;

subplot(211);
semilogx(f,m1db,'r^-',f,m2db,'bo-',f,m3db,'b*-',f,m4db,'rs-',f,m5db,'m*-',f,m6db,'r+-',f,m7db,'k-',...
f,m8db,'c*-',f,m9db,'rx-',f,m10db,'r*-',f,m11db,'r--',f,m12db,'r*-.',f,m13db,'r*--',f,m14db,'r--',f,m15db,'r-',f,mdb,'k*-');
grid; xlabel('Frequency (Hz)'); ylabel('Magnitude (dB)');
title('Multiple band PEQ filters');

subplot(212);
semilogx(f,p1,'r^-',f,p2,'bo-',f,p3,'b*-',f,p4,'rs-',f,p5,'m*-',f,p6,'r+-',f,p7,'k-',...
f,p8,'c*-',f,p9,'rx-',f,p10,'r*-',f,p11,'r--',f,p12,'r--',f,p13,'r*-.',f,p14,'r*--',f,p15,'r-',f,p,'k*-');
grid; xlabel('Frequency (Hz)'); ylabel('Phase (Degree)');
title('Multiple band PEQ filters');

end
