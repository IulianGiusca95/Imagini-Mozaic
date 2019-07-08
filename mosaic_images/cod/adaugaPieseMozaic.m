function imgMozaic = adaugaPieseMozaic(params)
%adaugaPieseMozaic
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);
switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);    
                imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        if (c == 3)
        %calculez media culorilor fiecarei imagini din colectie
       matriceImagini = zeros(N,4);
       for k = 1:N %iau fiecare imagine in parte
           %calculez media componentelor r g b
           rM=mean(mean(params.pieseMozaic(1:params.V,1:params.O,1,k)));
           gM=mean(mean(params.pieseMozaic(1:params.V,1:params.O,2,k)));
           bM=mean(mean(params.pieseMozaic(1:params.V,1:params.O,3,k)));
           %mediile r g b si indicele vor reprezenta o linie in matricea pe
           %care am declarat-o anterior.
           matriceImagini(k,1) = rM;
           matriceImagini(k,2) = gM;
           matriceImagini(k,3) = bM;
           matriceImagini(k,4) = k;
       end
        
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
               %Calculam media blocului din imaginea redimensionata
               rM=mean(mean(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,1)));
               gM=mean(mean(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,2)));
               bM=mean(mean(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,3)));
         
               
               
               %calculam cea mai apropiata valoare dintre media blocului si
               %o valoare din vectorul de imagini din colectie.
               
               minim = 255;
               indice = -1;
               
               % calculam distanta euclidiana a imaginilor
               for k = 1 : N
                   d = sqrt ( ((rM - matriceImagini(k,1)) * (rM - matriceImagini(k,1))) + ((gM - matriceImagini(k,2)) * (gM - matriceImagini(k,2))) +((bM - matriceImagini(k,3)) * (bM - matriceImagini(k,3))) );
                   if (d < minim)
                       minim = d;
                       indice = matriceImagini(k,4);
                   end
               end
               imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
               nrPieseAdaugate = nrPieseAdaugate+1;
               fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            
            end
       
        end
        
        else
           
           
            
             %calculez media culorilor fiecarei imagini din colectie
       matriceImagini = zeros(N,2);
       for k = 1:N %iau fiecare imagine in parte
           %calculez media componentelor r g b
           gray=mean(mean(rgb2gray(uint8( params.pieseMozaic(:,:,:,k)))));
           
           %mediile r g b si indicele vor reprezenta o linie in matricea pe
           %care am declarat-o anterior.
          matriceImagini(k,1) = gray;
          matriceImagini(k,2) = k;
       end
            
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
               %Calculam media blocului din imaginea redimensionata
               gray=mean(mean(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,1)));
               
               minim = 255;
               indice = -1;
               
               % calculam distanta euclidiana a imaginilor
               for k = 1 : N
                   d = sqrt ( ((gray - matriceImagini(k,1)) * (gray - matriceImagini(k,1))));
                   if (d < minim)
                       minim = d;
                       indice = matriceImagini(k,2);
                   end
               end
               
               imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = rgb2gray(uint8( params.pieseMozaic(:,:,:,indice)));
               nrPieseAdaugate = nrPieseAdaugate+1;
               fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
            
        end
        
    case 'distantaCulori'
        
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        nrPieseAdaugate = 0;
        
        if (c==3)
        
        %calculam distanta euclidiana ptr fiecare pixel in parte
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                minim = 1000000000;
                indice = -1;
                for k = 1 : N %pentru fiecare imagine in parte din colectie
                    
                    %efectuez diferenta pe componente R G B intre matrici
                    %de aceleasi dimensiuni
                    R=double(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,1)) - double(params.pieseMozaic(:,:,1,k));
                    G=double(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,2)) - double(params.pieseMozaic(:,:,2,k));
                    B=double(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,3)) - double(params.pieseMozaic(:,:,3,k));
                    
                    %ridic diferentele la patrat
                    RSq = R .* R;
                    GSq = G .* G;
                    BSq = B .* B;
                    
                    %fac suma patratelor
                    suma = sum(sum(RSq)) + sum(sum(GSq)) + sum(sum(BSq));
                    
                    %aplic radicalul si am aflat distanta euclidiana
                    d = sqrt(suma);
                    
                    
                    if (d < minim)
                        minim = d;
                        indice = k;
                    end
                end
               imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
               nrPieseAdaugate = nrPieseAdaugate+1;
               fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
              
            end
           
        end
        
        else
            
            %calculam distanta euclidiana ptr fiecare pixel in parte
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                minim = 1000000000;
                indice = -1;
                
                for k = 1 : N %pentru fiecare imagine in parte din colectie
                    
                    %efectuez diferenta pe componente R G B intre matrici
                    %de aceleasi dimensiuni
                    Gray=double(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,1)) - double(rgb2gray(uint8( params.pieseMozaic(:,:,:,k))));
                    GraySq = Gray .* Gray;
                    
                    suma = sum(sum(GraySq));
                    
                    d = sqrt(suma);
                    
                    if(d < minim)
                       minim = d;
                       indice = k;
                    end
                
                end 
               imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = rgb2gray(uint8( params.pieseMozaic(:,:,:,indice)));
               nrPieseAdaugate = nrPieseAdaugate+1;
               fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
        end
            
        end
        end
       
    
    otherwise
        fprintf('EROARE, optiune necunoscuta \n');
    
end

end
    
    
    
    
    
