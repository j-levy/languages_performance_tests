clear all;
leonardo = arduino('COM5', 'Leonardo');

N = 8000; %pr�-allocation de la taille du tableau de mesure
delay = 0.5; %secondes, temps entre chaque mesure

mesA0 = zeros(N,1);

meanA0 = 0;

i = 0;
disp 'D�but de mesure.'
while 1
    i = i+1;
    
    if i == N % on arrive en bout de tableau
        N = 2*N; %doubler la taille du tableau
        
        %r�allouer : sp�cifier une valeur OOB demande automatiquement la
        %r�allocation par Matlab.
        mesA0(N,1) = 0;
        disp ('Tableaux r�allou�s. Nouvelle taille :')
        disp (N)
    end
    
    
    
    mesA0(i) = readVoltage(leonardo, 'A0');
    
    %fprintf('Valeurs mesur�es : A0 = %.4f V\n',mesA0(i));

    
    pause(delay);
    
    if readDigitalPin(leonardo,'D7')
        disp 'Mesure interrompue (la pin D7 a quitt� le potentiel 0V)'
        break
    end
    
end
%%
% Cr�er des nouveaux tableaux sans les valeurs nulles (n�cessaires pour une
% belle allocation de m�moire)
close all;
mesA0_t = mesA0(1:i);
mesA0_t = mesA0_t*10 * 12; %Calcul de la puissance : 0.1 V/A donc 10A/V, tension de 12V

figure;
plot(mesA0_t)

% Filtage

fc = 0.1; % fr�quence de coupure
fs = 1/delay; % Fr�quence d'�chantillonnage

x = smooth(mesA0_t, 'moving');
[b,a] = butter(1,fc/(fs/2)); % Butterworth filter of order 30
x = filter(b,a,x); % Will be the filtered signal
hold on
plot(x)

%% R�cup�rer valeur moyenne en charge
median = max(x) - min(x);
moyenne = mean(x(x > median));
fprintf('Valeur moyenne en charge : %.4f W \n', moyenne)

