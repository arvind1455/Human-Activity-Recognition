load('workplace.mat')
fs = 32;
noverlap = 50;
%x Import data from the dataset model as column vector and name the
%respective columns based on the x, y & z axes.
spectrogram(x,[],[],[],fs)
nfft = 30000;
window_length = 100;
mywin = hamming(window_length);
wvtool(mywin);
spectrogram(x,mywin,noverlap,nfft,fs)