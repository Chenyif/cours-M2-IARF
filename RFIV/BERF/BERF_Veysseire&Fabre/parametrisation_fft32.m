function parametres = parametrisation_fft32(signal)

fen = hamming(length(signal));

% Calcul de la TF du sinal (partie reelle)
r_fft_signal = abs(fft(signal,128));
%r_fft_signal = abs(fft(signal,64));
parametres =  r_fft_signal(1:32);     

                                         
