function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

%completati codul Matlab
[h,w,c] = size(params.imgReferinta);
disp(h);
disp(w);
lungimeOrizontala = params.O * params.numarPieseMozaicOrizontala;

%calculeaza automat numarul de piese pe verticala

params.numarPieseMozaicVerticala=floor((((lungimeOrizontala) / w) * h) / params.V);
lungimeVerticala = params.V * params.numarPieseMozaicVerticala;
params.imgReferintaRedimensionata = imresize(params.imgReferinta,[lungimeVerticala,lungimeOrizontala]);
%imshow(params.imgReferintaRedimensionata);

[h1,w1,c1] = size(params.imgReferintaRedimensionata);

