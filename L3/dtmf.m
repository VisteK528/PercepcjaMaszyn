function out = dtmf(x, fs)
% x - wektor próbek audio
% fs - częstotliwość próbkowania

% możliwe etykiety danych
labels = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "*", "0", "#"];
x_indices = [1209, 1336, 1477];
y_indices = [697, 770, 852, 941];

win_len = 512;     % wielkość okna do analizy
win_overlap = 256; % nakładanie ramek
nfft = 512;        % liczba próbek do FFT

% wyznaczenie widma częstotliwości w oknach i wyznaczenie amplitudy funkcji składowych
[s, f, t] = spectrogram(x, win_len, win_overlap, nfft, fs);
A = abs(s) / nfft;

end