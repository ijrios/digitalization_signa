%================================================================================
%SCRIPT QUE REALIZA LA DIGITALIZACION Y RECUPERACION DE AUDIO PARAMETROS VARIABLE
%===============================================================================

clear all;
close all;
clc
disp("BIEVENIDOS AL PROGRAMA");
duracion=input('Ingrese la duracion de la grabacion que desea; entre 3 y 5 segundos');
Fs=input('Ingrese la frecuenci a la la que desea grabar el audio: ');

disp('presione una tecla para empezar a grabar...');
pause;

%Fs=44100; %Frecuencia de muestreo.
ObjetoAudio=audiorecorder(Fs,16,1); %Creacion del objeto de grabacion
recordblocking(ObjetoAudio,duracion); %Grabacion del sonido
audio=getaudiodata(ObjetoAudio, 'single');
audiowrite('audiograbado.wav',audio,Fs); %Graba y guarda la señal

disp('Grabaci?n terminada. El archivo ha sido guardado como "audiograbado.wav"...');

%Ingresamos el audio a analizar 
archivo=input('Escriba el nombre del archivo de audio que desea analizar: ','s');
[audio,Fs]=audioread(archivo);
audio=audio/max(max(abs(audio)));
audio=audio(:,1);
%Aqui pidemos al usuario cuantos bits decea usar para cuantizar el audio
n=input('ingrese el numero de bits  que desea usar: ');
q=2^n;
disp("q="+q);
%Hacemos que la señal sea positiva
audio=(audio+1)*0.99;
audio=(q/2)*audio;
audio=floor(audio);
%Realizamos la transformada de fourier del audio
s=fftshift(abs(fft(audio)));
%Definimos el periodo de la señal
Ts=1/Fs;
%Construyendo el vector de tiempo
t=0:Ts:Ts*length(audio)-Ts; 
f0=Fs/length(t);
%Se construye el eje de las frecuencias
f=-Fs/2:f0:Fs/2-f0;

% GRAFICAMOS LOS AUDIOS
figure(1);
subplot(2,1,1);
%Graficamos el audio original en el tiempo
plot(t,audio);
grid on;
xlabel('Tiempo [s]'); 
ylabel('Amplitud [V]');
title('Forma de onda del audio original');
subplot(2,1,2);
plot(f,s);
grid on;
xlabel('Frecuencia [KHz]'); 
ylabel('Magnitud [V^2]');
title('Espectro del audio original');

%Convertimos a binario el audio
audio=dec2bin(audio,n);
trendebits=reshape(audio',1,[]);
%disp(trendebits);
columnadebits=reshape(trendebits,n,[]);
columnaObtenida = reshape(columnadebits',[],n);
%disp(columnaObtenida);
audioRecuperado= bin2dec(columnaObtenida);
audioRecuperado=(audioRecuperado/((2^n)/2))-1;
sr=fftshift(abs(fft(audioRecuperado)));
Ts=1/Fs;
%Construimos el vector de tiempo
t=0:Ts:Ts*length(audioRecuperado)-Ts;
f0=Fs/length(t); %Tamaño de paso
%Se construye el eje de las frecuencias
f=-Fs/2:f0:Fs/2-f0;

%GRAFICAMOS EL AUDIO
figure(2);
subplot(2,1,1);
plot(t,audioRecuperado); % Graficando la señal en el tiempo (forma de onda)
grid on;
xlabel('Tiempo [s]');
ylabel('Amplitud [V]');
title('Forma de onda del audio muestreado');
subplot(2,1,2);
plot(f,sr);
grid on;
xlabel('Frecuencia [KHz]'); ylabel('Magnitud [V^2]');
title('Espectro del audio muestreado');

% ================ Audio recuperado =======================================
disp('Presione una tecla para escuchar el audio...');
pause;
sound(audioRecuperado,Fs);
%==========================================================================
