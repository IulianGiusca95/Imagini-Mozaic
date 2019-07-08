%tema 1: REALIZAREA IMAGINILOR MOZAIC
%

%%
%seteaza parametri

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread('E:\An3\Semestrul 1\Vedere Artificiala\tema1\data\imaginiTest\ferrari.jpeg');

%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = [pwd 'E:\An3\Semestrul 1\Vedere Artificiala\tema1\data'];
params.tipImagine = 'png';

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 25;
%numarul de piese ale mozaciului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = 0;

params.O=40;
params.V=30;

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie','distantaCulori'%params.criteriu = 'aleator';
params.criteriu = 'distantaCuloareMedie';
%params.criteriu = 'distantaCulori';

params.label = -1;

%%
%apeleaza functia principala
imgMozaic = construiesteMozaic(params);
imwrite(imgMozaic,'mozaic.jpg');
figure, imshow(imgMozaic)