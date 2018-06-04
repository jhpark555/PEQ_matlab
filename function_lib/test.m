function test(gain, q, fc,file_name)
disp('This is the PEQ biquad filter simulation program');
disp('All rights belong to philip.park@esstech.com');

[audio_file,fs]=audioread(file_name);
Ts=1/fs;

[B1,A1]=high_pass(gain,q,fc,fs);
[B2,A2]=low_pass(gain,q,fc,fs);
[B3,A3]=biquad_peak(gain,q,fc,fs);
[B4,A4]=biquad_peak(gain,q,fc,fs);
[B5,A5]=gain_pass(gain,q,fc,fs);
[B6,A6]=biquad_peak(gain,q,fc,fs);
[B7,A7]=biquad_peak(gain,q,fc,fs);

sys1=minreal(tf(B1,A1,Ts));
sys2=minreal(tf(B2,A2,Ts));
sys3=minreal(tf(B3,A3,Ts));
sys4=minreal(tf(B4,A4,Ts));
sys5=minreal(tf(B5,A5,Ts));
sys6=minreal(tf(B6,A6,Ts));
sys7=minreal(tf(B7,A7,Ts));

sys=sys1*sys2*sys3*sys4*sys5*sys6*sys7;
[B,A]=tfdata(sys,'v');

y=dlsim(B,A,audio_file);
audiowrite('output.wav',y,fs);

