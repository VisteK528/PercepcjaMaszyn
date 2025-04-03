[x, fs] = audioread("data/dtmf.wav");

characters = dtmf(x, fs);

disp(characters);
