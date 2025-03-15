[x, fs] = audioread("dtmf.wav");

x_indices = [1209, 1336, 1477];
y_indices = [697, 770, 852, 941];

labels = [["1", "2", "3"]; ["4", "5", "6"]; ["7", "8", "9"]; ["*", "0", "#"]];

win_len = 512;     % wielkość okna do analizy
win_overlap = 256; % nakładanie ramek
nfft = 1024;        % liczba próbek do FFT

% wyznaczenie widma częstotliwości w oknach i wyznaczenie amplitudy funkcji składowych
[s, f, t] = spectrogram(x, win_len, win_overlap, nfft, fs);

step = (fs / 2) / nfft;

A = abs(s) / nfft;
shape_A = size(A);
threshold = 0.002;

for i=1:shape_A(1)
    for j=1:shape_A(2)
        if A(i, j) < threshold
            A(i, j) = 0;
        end
    end
end

numbers = [];
k = 1;
found_number = false;
for j=1:shape_A(2)
    [peaks, locs] = findpeaks(A(:, j), "MinPeakHeight", threshold);
    locs_shape = size(locs);
    if (locs_shape(1) == 2) & ~found_number
        found_number = true;

        k = k + 1;
        frequencies = locs * step * 2;

        [~, I_y] = min(abs(y_indices - frequencies(1)));
        [~, I_x] = min(abs(x_indices - frequencies(2)));
        disp(labels(I_y, I_x));

        
       

    elseif (locs_shape(1) == 0) & found_number
        found_number = false;
    end
end

disp(numbers);







