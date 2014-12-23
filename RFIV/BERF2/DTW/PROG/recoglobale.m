

function [matriceFinal,mot]=recoglobale(nomFichier)
%mot a tester
test=nomFichier;
x= extractionCoeffCepstraux(test);


% Paramétrisation

mots={'cinq','cinquante','deux','diviser','dix','douze','egal','et','fois','huit','moins','multiplier','neuf','onze','par','plus','quarante','quatorze','quatre','quinze','seize','sept','six','soixante','sur','treize','trente','trois','un','vingt','zero'};

locuteurs={'alban','brice','dominique','eric','etienne','gabrielides','hyliass','jean','nabil','thomas'};


%ensemble des coeffs spectraux de tous les fichiers
refs={};

%refs contient tous les coeffs spectraux de références
for i=1: length(mots)

    for j=1: length(locuteurs)
        %['../Sons OK/' mots{i} '_' locuteurs{j} '_2012.wav'];
        refs{i,j} = extractionCoeffCepstraux(['../Sons OK/' mots{i} '_' locuteurs{j} '_2012.wav']);
    end
end



close all;

disp(['traitement en cours...']);

matriceCoutTotal = [];

for i=1 : length(mots)
    for j =1 : length(locuteurs)
    
    
    [chemin dynamicT coutTotal,ens] = DTW_IAN(x, refs{i,j});
    matriceCoutTotal(i,j) = coutTotal;

 %   nomFig= [ 'test: ' ' ref: ' mots{i} '_' locuteurs{j}];
 %   h=figure('Name',nomFig);
 %   set(h,'visible','off');
 %   imagesc(chemin), xlabel('Test'), ylabel('Ref')
 %   saveas(h,['../images/' nomFig],'jpg');

    

    end 
end

[dist,mot,loc]=decisionGlobale(matriceCoutTotal);

    phrase=['fichier ' test ' reconnu comme ' mots{mot} ' prononce par ' locuteurs{loc} ' avec distance de ' num2str(dist) ];
    fprintf ('\n');
    
    disp(phrase)


%for i=1 : length(mots)
%    for j =1 : length(locuteurs)
%        h=figure('Name',[mots{i} '_' locuteurs{j}],'NumberTitle','off');
%        set(h,'visible','off');
%        bar(matriceCoutTotal(i,:))
%        title(nom{i})
%        set(gca,'XTick',[1 2 3 4 5 6 7 8 9 10 11 12 13])
%        set(gca,'XTickLabel',{'alpha' , 'bravo' ,'charlie',  %'delta' ,'echo' ,'foxtrott' ,'golf' ,'hotel', 'india', 'juliett' ,'kilo' ,'lima' , 'mike'})
%     saveas(h,['../results/' nom{i}],'jpg');

%end

matriceFinal={};

for i=1 : length(mots)
    matriceFinal{i+1,1} = mots{i};
end


for j=1 : length(locuteurs)
    matriceFinal{1,j+1} = locuteurs{j};
end

for i=1 : length(mots)
   
    for j =1 : length(locuteurs)
           
           matriceFinal{i+1,j+1} = matriceCoutTotal(i,j);
    end
end


%fileID = fopen(['../matrix/a.txt'],'w');
%formatSpec = '%s %f %f %f %f %f %f %f %f %f %f\n';
%for i=2:length(mots)
% fprintf(fileID,formatSpec,matriceFinal{i,:});
%end
%fclose(fileID);








