function out = dtmf(x, fs)
% x - wektor próbek audio
% fs - częstotliwość próbkowania

% Autorzy:
% Piotr Patek, 324 789
% Damian Baraniak, 324 851


% możliwe etykiety danych
column_frequencies = [1209, 1336, 1477];
row_frequencies = [697, 770, 852, 941];

labels = [
    ["1", "2", "3"];
    ["4", "5", "6"];
    ["7", "8", "9"];
    ["*", "0", "#"]
    ];

win_len = 512;     % wielkość okna do analizy
win_overlap = 256; % nakładanie ramek
nfft = 1024;        % liczba próbek do FFT

[s, ~, ~] = spectrogram(x, win_len, win_overlap, nfft, fs);
step = fs / nfft;

A = abs(s) / nfft;
shape_A = size(A);
threshold = 0.002;
A(A < threshold) = 0;


out = '';
k = 1;
found_number = false;
for j=1:shape_A(2)
    [~, locs] = findpeaks(A(:, j), "MinPeakHeight", threshold);
    locs_shape = size(locs);
    if (locs_shape(1) == 2) & ~found_number
        found_number = true;

        k = k + 1;
        found_frequencies = locs * step;

        [~, I_x] = min(abs(row_frequencies - found_frequencies(1)));
        [~, I_y] = min(abs(column_frequencies - found_frequencies(2)));
        out(k) = labels(I_x, I_y);

    elseif (locs_shape(1) == 0) & found_number
        found_number = false;
    end
end
end