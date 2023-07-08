%% Inicio (carga de datos)
clc;
clear;
close all;

% Cargar una imagen de ejemplo
imagen = imread('img1.jpg');

% Sepearamos en los tres espectros
imgRojo = imagen(:,:,1);
imgVerde = imagen(:,:,2);
imgAzul = imagen(:,:,3);

% Obtener el histograma de cada uno de los espectros de la imagen
histogramaRojo = imhist(imgRojo);  % Histograma del canal rojo
histogramaiVerde = imhist(imgVerde);  % Histograma del canal verde
histogramaAzul = imhist(imgAzul);  % Histograma del canal azul

%% Grafico en la pantalla

% Crear una figura para la pantalla de fondo
figure('Units', 'pixels', 'Position', [160, 55, 1200, 700]);

%% Imagenes

% Crear un subplot para la imagen original
subplot(3,4,[1 2 5 6]);
imagenOriginalPlot = imshow(imagen);
title('Imagen Original');
%Crear un subplot para la imagen ecualizada
subplot(3,4,[3 4 7 8]);
imagenEcualizadaPlot = imshow(imagen);
title('Imagen Actualizada');
%% Histogramas

% Crear un subplot para el histograma red
subplot(3,4,10);
histogramaRojoPlot = bar(histogramaRojo,'r');
title(sprintf('Histograma Rojo\n'));

% Crear un subplot para el histograma green
subplot(3,4,11);
histogramaVerdePlot = bar(histogramaiVerde,'g');
title(sprintf('Histograma Verde\n'));

% Crear un subplot para el histograma blue
subplot(3,4,12);
histogramaAzulPlot = bar(histogramaAzul,'b');
title(sprintf('Histograma Azul\n'));
%% Labels y boton
% Crear el label
labelR = uicontrol('Style', 'text', 'Position', [50 250 300 20]);
labelR.FontSize = 12;
% labelR.ForegroundColor = 'r';
labelR.FontWeight = 'bold';
labelV = uicontrol('Style', 'text', 'Position', [53 200 300 20]);
labelV.FontSize = 12;
labelV.FontWeight = 'bold';
% labelV.ForegroundColor = 'g';
labelA = uicontrol('Style', 'text', 'Position', [48 150 300 20]);
labelA.FontSize = 12;
labelA.FontWeight = 'bold';
% labelA.ForegroundColor = 'b';

% Crear un botón
btn = uicontrol('Style', 'pushbutton', 'String', 'Histogramas originales', ...
    'Position', [80 50 180 50], ...
    'Callback', @buttonCallback);
btn.FontName = 'bold';
btn.FontSize=12;
btn.BackgroundColor = 'w';
btn.ForegroundColor='r';
%% Creamos el slider para cada espectro

% Crear un slider
sliderRojo = uicontrol('Style', 'slider', 'Min',-255 , 'Max', 255, 'Value', 0, ...
    'Position', [390 25 200 15],'BackgroundColor', 'r');

sliderVerde = uicontrol('Style', 'slider', 'Min',-255 , 'Max', 255, 'Value', 0, ...
    'Position', [640 25 200 15],'BackgroundColor', 'g');

sliderAzul = uicontrol('Style', 'slider', 'Min', -255, 'Max', 255, 'Value', 0, ...
    'Position', [890 25 200 15],'BackgroundColor', 'b');


%% Añadimo los eventos a los slider

% Agregar una función de callback al slider
sliderRojo.Callback = @(src, event) actualizarHistograma(src,sliderVerde,sliderAzul,labelR,labelV,labelA,histogramaRojoPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot,histogramaVerdePlot,histogramaAzulPlot);
sliderVerde.Callback = @(src, event) actualizarHistograma(sliderRojo,src,sliderAzul,labelR,labelV,labelA,histogramaVerdePlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot,histogramaVerdePlot,histogramaAzulPlot);
sliderAzul.Callback = @(src, event) actualizarHistograma(sliderRojo,sliderVerde,src,labelR,labelV,labelA,histogramaAzulPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot,histogramaVerdePlot,histogramaAzulPlot);


%% Creamos un funcion que maneje el slider y actualice los datos

function actualizarHistograma(sliderRojo,sliderVerde,sliderAzul,labelR,labelV,labelA,histogramaRojoPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot,histogramaVerdePlot,histogramaAzulPlot)
    valorR=sliderRojo.Value;
    valorV=sliderVerde.Value;
    valorA=sliderAzul.Value;

    Rojo= Fundos(imgRojo,valorR);
    Verde= Fundos(imgVerde,valorV);
    Azul= Fundos(imgAzul,valorA);

    disp(['Valor del slida Rojo: ', num2str(valorR)]);
    disp(['Valor del slida Verde: ', num2str(valorV)]);
    disp(['Valor del slida Azul: ', num2str(valorA)]);

    labelR.String = ['Slider Rojo = ', num2str(valorR)];
    labelV.String = ['Slider Verde = ', num2str(valorV)];
    labelA.String = ['Slider Azul = ', num2str(valorA)];


    histogramaRojoPlot.YData=imhist(Rojo);
    histogramaVerdePlot.YData=imhist(Verde);
    histogramaAzulPlot.YData=imhist(Azul);
    
    imgRojoPlot=Rojo;
    imgRojoVerde=Verde;
    imgRojoAzul=Azul;

    ImgNew(:,:,1)=imgRojoPlot;
    ImgNew(:,:,2)=imgRojoVerde;
    ImgNew(:,:,3)=imgRojoAzul;

    imagenEcualizadaPlot.CData=ImgNew;


end

%% funcion del boton

% Función de devolución de llamada para el botón
    function buttonCallback(~, ~)
        clf;  % Eliminar todos los gráficos actuales en la ventana
        DeberEql;  % Vuelve a ejecutar el script principal desde cero
    end








