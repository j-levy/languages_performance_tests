clear all;
leonardo = arduino('COM5', 'Leonardo');

N = 8000; %pré-allocation de la taille du tableau de mesure
delay = 0.5; %secondes, temps entre chaque mesure

mesA0 = zeros(N,1);
mesA1 = zeros(N,1);

meanA0 = 0;
meanA1 = 0;

i = 0;
while 1
    i = i+1;
    
    if i == N % on arrive en bout de tableau
        N = 2*N; %doubler la taille du tableau
        
        %réallouer : spécifier une valeur OOB demande automatiquement la
        %réallocation par Matlab.
        mesA0(N,1) = 0;
        mesA1(N,1) = 0;   
        disp ('Tableaux réalloués. Nouvelle taille :')
        disp (N)
    end
    
    
    
    mesA0(i) = readVoltage(leonardo, 'A0');
    mesA1(i) = readVoltage(leonardo, 'A1');
    
    fprintf('Valeurs mesurées : A0 = %.4f V, A1 = %.4f V\n',mesA0(i),mesA1(i));

    
    pause(delay);
    
    if readDigitalPin(leonardo,'D7')
        disp 'Mesure interrompue (la pin D7 a quitté le potentiel 0V)'
        break
    end
    
end
% Créer des nouveaux tableaux sans les valeurs nulles (nécessaires pour une
% belle allocation de mémoire)
mesA0_t = mesA0(1:i);
mesA1_t = mesA1(1:i);
mesA0_t = mesA0_t*10 * 12; %Calcul de la puissance : 0.1 V/A donc 10A/V, tension de 12V
mesA1_t = mesA1_t*10 * 12;
figure;
plot(mesA0_t)
hold on;
plot(mesA1_t)

%% filtering

fc = 0.1; % Cut off frequency
fs = 2; % Sampling rate

[b,a] = butter(6,fc/(fs/2)); % Butterworth filter of order 30
x = filter(b,a,mesA0_t); % Will be the filtered signal
hold on
plot(x)
