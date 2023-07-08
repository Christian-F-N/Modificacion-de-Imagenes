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
labelR = uicontrol('Style', 'text', 'Position', [50 300 300 20]);
labelR.FontSize = 12;
% labelR.ForegroundColor = 'r';
labelR.FontWeight = 'bold';
labelV = uicontrol('Style', 'text', 'Position', [53 250 300 20]);
labelV.FontSize = 12;
labelV.FontWeight = 'bold';
% labelV.ForegroundColor = 'g';
labelA = uicontrol('Style', 'text', 'Position', [48 200 300 20]);
labelA.FontSize = 12;
labelA.FontWeight = 'bold';
% labelA.ForegroundColor = 'b';

% Crear un botón
btn = uicontrol('Style', 'pushbutton', 'String', 'Histogramas originales', ...
    'Position', [150 100 150 40], ...
    'Callback', @buttonCallback);

%% Creamos el slider para cada espectro

% Crear un slider
sliderRojo = uicontrol('Style', 'slider', 'Min',-255 , 'Max', 255, 'Value', 0, ...
    'Position', [390 25 200 15],'BackgroundColor', 'r','SliderStep', [1/510 1/510]);

sliderVerde = uicontrol('Style', 'slider', 'Min',-255 , 'Max', 255, 'Value', 0, ...
    'Position', [640 25 200 15],'BackgroundColor', 'g','SliderStep', [1/510 1/510]);

sliderAzul = uicontrol('Style', 'slider', 'Min', -255, 'Max', 255, 'Value', 0, ...
    'Position', [890 25 200 15],'BackgroundColor', 'b','SliderStep', [1/510 1/510]);


%% Añadimo los eventos a los slider

% Agregar una función de callback al slider
sliderRojo.Callback = @(src, event) actualizarHistograma(src,sliderVerde,sliderAzul,labelR,labelV,labelA,histogramaAzulPlot,histogramaVerdePlot,histogramaRojoPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot);
sliderVerde.Callback = @(src, event) actualizarHistograma(sliderRojo,src,sliderAzul,labelR,labelV,labelA,histogramaAzulPlot,histogramaVerdePlot,histogramaRojoPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot);
sliderAzul.Callback = @(src, event) actualizarHistograma(sliderRojo,sliderVerde,src,labelR,labelV,labelA,histogramaAzulPlot,histogramaVerdePlot,histogramaRojoPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot);


%% Creamos un funcion que maneje el slider y actualice los datos

% Función de callback para actualizar el histograma ecualizado
function actualizarHistograma(sliderRojo,sliderVerde,sliderAzul,labelR,labelV,labelA,histogramaAzulPlot,histogramaVerdePlot,histogramaRojoPlot,imgRojo,imgVerde,imgAzul,imagenEcualizadaPlot)
    
% Obtenemos los valores de los sliders
    valorR=sliderRojo.Value;
    valorV=sliderVerde.Value;
    valorA=sliderAzul.Value;
    
    % Asignamos los valores de los sliders en los labels
    labelR.String = ['Slider Rojo = ', num2str(valorR)];
    labelV.String = ['Slider Verde = ', num2str(valorV)];
    labelA.String = ['Slider Azul = ', num2str(valorA)];
    
    % Muestra por consola el valor de salida de los sliders
    disp('Valores..........');
    disp(['Valor del slida Rojo: ', num2str(valorR)]);
    disp(['Valor del slida Verde: ', num2str(valorV)]);
    disp(['Valor del slida Azul: ', num2str(valorA)]);
    
    % Obtenemos el tamaño de la matriz 
    [fila, columna]=size(imgRojo);
            
    % Recorremoas toda la matris sumando el valor de los sliders en cada espectro    
    for i=1:fila
        for j=1:columna
            if ((imgRojo(i,j)+valorR) >= 255)
                imgRojo(i,j) = 255;
            elseif ((imgRojo(i,j)+valorR) <= 0)
                imgRojo(i,j) = 0;
            else
                imgRojo(i,j) = imgRojo(i,j)+valorR;
            end
            
            if ((imgVerde(i,j)+valorV) >= 255)
                imgVerde(i,j) = 255;
            elseif ((imgVerde(i,j))+valorV <= 0)
                imgVerde(i,j) = 0;
            else
                imgVerde(i,j) = imgVerde(i,j)+valorV;
            end
            
            if ((imgAzul(i,j)+valorA) >= 255)
                imgAzul(i,j) = 255;
            elseif ((imgAzul(i,j)+valorA) <= 0)
                imgAzul(i,j) = 0;
            else
                imgAzul(i,j) = imgAzul(i,j)+valorA;
            end
         
        end
    end
                
    % Asignamos los nuevos valores a los histogramas     
    histogramaRojoPlot.YData=imhist(imgRojo);
    histogramaVerdePlot.YData=imhist(imgVerde);
    histogramaAzulPlot.YData=imhist(imgAzul);
    
    % Unimos los tres espectros para contruir la nueva imagen 
    ImgNew(:,:,1)=imgRojo;
    ImgNew(:,:,2)=imgVerde;
    ImgNew(:,:,3)=imgAzul;
    imagenEcualizadaPlot.CData=ImgNew;
    
        % Permite acceder a las propiedades del objeto 
%         axR = histogramaRojoPlot.Parent; 
%         axV = histogramaVerdePlot.Parent; 
%         axA = histogramaAzulPlot.Parent; 
        
%         % Recuperamos el valor maximo de cada uno de los histogramas
%         maxcountR = max(histogramaRojoPlot.YData);
%         maxcountV = max(histogramaVerdePlot.YData);
%         maxcountA = max(histogramaAzulPlot.YData);
%         
%         % Reas
%         axR.YLim = [0 maxcountR];
%         axR.YTick = round([0 maignamos el numero de pixceles en el eje Y dependiendo de la
%         % intensidadxcountR/2 maxcountR], 2, 'significant');
%         axV.YLim = [0 maxcountV];
%         axV.YTick = round([0 maxcountV/2 maxcountV], 2, 'significant');
%         axA.YLim = [0 maxcountA];
%         axA.YTick = round([0 maxcountA/2 maxcountA], 2, 'significant');
end

%% funcion del boton

% Función de devolución de llamada para el botón
    function buttonCallback(~, ~)
        clf;  % Eliminar todos los gráficos actuales en la ventana
        Nuevo;  % Vuelve a ejecutar el script principal desde cero
    end








