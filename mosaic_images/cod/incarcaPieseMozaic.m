function pieseMozaic = incarcaPieseMozaic(params)
%citeste toate cele N piese folosite la mozaic din directorul corespunzator
%toate cele N imagini au aceeasi dimensiune H x W x C, unde:
%H = inaltime, W = latime, C = nr canale (C=1  gri, C=3 color)
%functia intoarce pieseMozaic = matrice H x W x C x N
%pieseMoziac(:,:,:,i) reprezinta piese numarul i 


switch (params.label)
    case -1

%completati codul Matlab
filelist = dir('C:\Users\Iulian\Desktop\tema1\data\colectie\*.png');
pieseMozaic = [];
for index = 1:length(filelist)
    imgName = ['C:\Users\Iulian\Desktop\tema1\data\colectie\' filelist(index).name];
    pieseMozaic(:,:,:,index) = [imread(imgName)];
end

    otherwise 
        fprintf('Incarcam piesele pentru mozaic din director \n');
        filelist = dir('C:\Users\Iulian\Desktop\tema1\data\batches\*.jpg');
        pieseMozaic = [];
        contor=0;
        load('data_batch_1.mat')
        fprintf('Incarcam batch 1 \n');
        for i = 1 : 10000
            if labels(i,1) == params.label
                index = int2str(i);
                imgName = strcat('C:\Users\Iulian\Desktop\tema1\data\batches\batch',index,'.jpg');
                contor = contor+1;
                pieseMozaic(:,:,:,contor)= [imread(imgName)];
            end
        end
        fprintf('Incarcam batch 2 \n');
        load('data_batch_2.mat')
        for i = 1 : 10000
            if labels(i,1) == params.label
                index = int2str(10000+i);
                imgName = strcat('C:\Users\Iulian\Desktop\tema1\data\batches\batch',index,'.jpg');
                contor=contor+1;
                pieseMozaic(:,:,:,contor)= [imread(imgName)];
            end
        end
        fprintf('Incarcam batch 3 \n');
        load('data_batch_3.mat')
        for i = 1 : 10000
            if labels(i,1) == params.label
                index = int2str(20000+i);
                imgName = strcat('C:\Users\Iulian\Desktop\tema1\data\batches\batch',index,'.jpg');
                contor=contor+1;
                pieseMozaic(:,:,:,contor)= [imread(imgName)];
            end
        end
        fprintf('Incarcam batch 4 \n');
        load('data_batch_4.mat')
        for i = 1 : 10000
            if labels(i,1) == params.label
                index = int2str(30000+i);
                imgName = strcat('C:\Users\Iulian\Desktop\tema1\data\batches\batch',index,'.jpg');
                contor=contor+1;
                pieseMozaic(:,:,:,contor)= [imread(imgName)];
            end
        end
        fprintf('Incarcam batch 5 \n');
        load('data_batch_5.mat')
        for i = 1 : 10000
            if labels(i,1) == params.label
                index = int2str(40000+i);
                imgName = strcat('C:\Users\Iulian\Desktop\tema1\data\batches\batch',index,'.jpg');
                contor=contor+1;
                pieseMozaic(:,:,:,contor)= [imread(imgName)];
            end
        end
        fprintf('Incarcam batch test \n');
        load('test_batch.mat')
        for i = 1 : 10000
            if labels(i,1) == params.label
                 index = int2str(50000+i);
                imgName = strcat('C:\Users\Iulian\Desktop\tema1\data\batches\batch',index,'.jpg');
                contor=contor+1;
                pieseMozaic(:,:,:,contor)= [imread(imgName)];
            end
        end
        
end

        
        

if params.afiseazaPieseMozaic
    %afiseaza primele 100 de piese ale mozaicului
    figure,
    title('Primele 100 de piese ale mozaicului sunt:');
    idxImg = 0;
    for i = 1:10
        for j = 1:10
            idxImg = idxImg + 1;
            subplot(10,10,idxImg);
            imshow(pieseMozaic(:,:,:,idxImg));
        end
    end
    drawnow;
    pause(2);
end
