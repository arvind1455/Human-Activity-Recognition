function Hd = Lowpass
%LOWPASS Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.5 and DSP System Toolbox 9.7.
% Generated on: 09-Nov-2019 20:07:25

% Equiripple Lowpass filter designed using the FIRPM function.

% All frequency values are in Hz.
Fs = 32;  % Sampling Frequency

Fpass = 0.2;             % Passband Frequency
Fstop = 1;               % Stopband Frequency
Dpass = 0.057501127785;  % Passband Ripple
Dstop = 0.0001;          % Stopband Attenuation
dens  = 20;              % Density Factor

% Calculate the order from the parameters using FIRPMORD.
[N, Fo, Ao, W] = firpmord([Fpass, Fstop]/(Fs/2), [1 0], [Dpass, Dstop]);

% Calculate the coefficients using the FIRPM function.
b  = firpm(N, Fo, Ao, W, {dens});
Hd = dfilt.dffir(b);

% [EOF]
trial = 'Walk\Accelerometer-2011-03-24-09-52-11-walk-f1.txt'

% READ THE ACCELEROMETER DATA FILE
dataFile = fopen(trial,'r');
data = fscanf(dataFile,'%d\t%d\t%d\n',[3,inf]);

% CONVERT THE ACCELEROMETER DATA INTO REAL ACCELERATION VALUES
% mapping from [0..63] to [-14.709..+14.709]
noisy_x = -14.709 + (data(1,:)/63)*(2*14.709);
noisy_y = -14.709 + (data(2,:)/63)*(2*14.709);
noisy_z = -14.709 + (data(3,:)/63)*(2*14.709);

% REDUCE THE NOISE ON THE SIGNALS BY MEDIAN FILTERING
n = 3;      % order of the median filter
x = medfilt1(noisy_x,n);
y = medfilt1(noisy_y,n);
z = medfilt1(noisy_z,n);
numSamples = length(x);

% Calculate the coefficients using the FIRPM function.
Hp_x54 = filter(Hd,x);
Hp_y54 = filter(Hd,y);
Hp_z54 = filter(Hd,z);

Bp_x = filter(Hd,Hp_x54);
Bp_y = filter(Hd,Hp_y54);
Bp_z = filter(Hd,Hp_z54);

% DISPLAY THE RESULTS
time = 1:1:numSamples;
% noisy signal
figure,
    subplot(3,1,1);
    plot(time,noisy_x,'-');
    axis([0 numSamples -14.709 +14.709]);
    title('Noisy accelerations along the x axis');
    subplot(3,1,2);
    plot(time,noisy_y,'-');
    axis([0 numSamples -14.709 +14.709]);
    ylabel('acceleration [m/s^2]');
    title('Noisy accelerations along the y axis');
    subplot(3,1,3);
    plot(time,noisy_z,'-');
    axis([0 numSamples -14.709 +14.709]);
    xlabel('time [samples]');
    title('Noisy accelerations along the z axis');
% clean signal
figure,
    subplot(3,1,1);
    plot(time,Bp_x,'-');
    axis([0 numSamples -14.709 +14.709]);
    title('Filtered accelerations along the x axis');
    subplot(3,1,2);
    plot(time,Bp_y,'-');
    axis([0 numSamples -14.709 +14.709]);
    ylabel('acceleration [m/s^2]');
    title('Filtered accelerations along the y axis');
    subplot(3,1,3);
    plot(time,Bp_z,'-');
    axis([0 numSamples -14.709 +14.709]);
    xlabel('time [samples]');
    title('Filtered accelerations along the z axis');
