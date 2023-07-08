function img_eq = MiEqualizador(img,a)
counts =imhist(img);
%función de distribución acumulativa
%que representa la probabilidad acumulativa de que una intensidad dada 
%sea menor o igual que un valor específico.
cdf = cumsum(counts);
cdf_normalized = cdf / sum(counts);
img_eq = uint8((interp1(0:255, cdf_normalized,double(img(:))))*a/1);
% Se especifica que los valores de entrada están en el rango de 0 a 255 y 
% se utiliza cdf_normalized como los valores correspondientes en el eje Y. 
% La función interp1 asignará nuevos valores a los píxeles 
% basándose en su correspondiente valor en la CDF normalizada.
img_eq = reshape(img_eq, size(img));
%vuelve a formar una matriz como la de la imagen 
end

