function img_reconstruida = Fundos(img,a)
counts =imhist(img);
% realiza la suma acumulativa de los valores del histograma
cdf = cumsum(counts);
% normalizamos los valores
cdf_normalized = cdf / sum(counts);
% interpola los valores de la CDF para asignar nuevos valores de intensidad
% a cada píxel equalizado
img_eq = interp1(0:255, cdf_normalized,double(img(:)));
%reorganiza para que tenga las mismas dimensiones que la imagen de entrada.
img_eq = reshape(img_eq, size(img));
min_val = min(img_eq(:));
max_val = max(img_eq(:));
img_reconstruida = uint8(a+(img_eq - min_val) * (255 / (max_val - min_val)));
end

