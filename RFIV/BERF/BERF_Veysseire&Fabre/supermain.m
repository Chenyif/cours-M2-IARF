%[signaux,signauxParam,donneesApp,donneesTest,listeMean,listeCov,arrayDonneesApp,matScores,listeScore,result,valeur] = supermain('FFT','loi normale')

 %function [signaux,signauxParam,donneesApp,donneesTest,listeMean,listeCov,arrayDonneesApp,matScores,listeScore,result,valeur] = supermain(parametrisation,methodeClassif,kval)

% result = supermain(parametrisation,methodeClassif,k)

function [result] = supermain(parametrisation,methodeClassif,kval)

% les différentes valeurs de parametrisation sont :
% 'FFT'
% 'cepstre'
% 'MFCC'

% les différentes valeurs de methodeClassif sont :
% 'loi normale'
% 'KPPV'


%on a 10 classes de son
classes = {'aa','ee','eh','eu','ii','oe','oh','oo','uu','yy'};

%la matrice de score
matscore={};

%les différents signaux récupérés
signaux={};

%les différents signaux parametrisés
signauxParam={};

%on recupère tous les signaux dans une cellule 10*100
%la cellule signaux{i}{j} renverra donc le jieme signal de la classe i 

valeur={};



L=length(classes);

%-------------RECUPERATION DU SIGNAL---------------%

for c=1:L 
    %pour chaque classe on recupere les 100 signaux
    for numero=1:100
        %on recupere les donnees
        %a partir du repertoire Signal
        v=['Signal/' classes{c} num2str(numero-1,'%.2d') '.wav'];
        [s,fs]=wavread(v);
        
        signaux{c,numero}=s;
        
        switch parametrisation
            case 'FFT',
                %parametrisation du vecteur
                vect=parametrisation_fft32(s);
                %on transpose
                vect=vect';
                %on ajoute le vecteur paramétrisé à la liste
                % ici on ordone les vecteurs lignes en colonne pour prévoir un passage
                %moins douloureux de la structure cells à Mat, d'où
                %{numero,1} et pas {numero} 
                signauxParam{c}{numero,1}=vect;

            case 'cepstre'
                %parametrisation du vecteur
                vect=parametrisation_cepstre(s);
                                
               
                %on transpose
                vect=vect';
                
                

                signauxParam{c}{numero,1}=vect;
                

            case 'MFCC'
                
                vect=melcepst(s,fs);
                vect=sum(vect);

                signauxParam{c}{numero,1}=vect;




            otherwise
                error('parametrisation non pris en charge');
        end
        
    end
end


%--------------------APPRENTISSAGE--------------------%

binf=0;


donneesApp={};
donneesTest={};

%utilisé seulement pour loi normale
listeMean={};
listeCov={};

%utilisé pour les KPPV

arrayDonneesApp= [];

switch methodeClassif

%------------------LOI NORMALE------------------------%
    case 'loi normale'
        
        for c=1:L
                
                %1
                donneesApp{c}=signauxParam{c}(1:80,1);
                donneesTest{c}=signauxParam{c}(81:end,1);
           
                %2
                %donneesApp{c}=signauxParam{c}(21:100,1);
                %donneesTest{c}=signauxParam{c}(1:20,1);

                %3%
                %donneesApp{c}=[signauxParam{c}(41:100,1);signauxParam{c}(1:20,1)];
                %donneesTest{c}=signauxParam{c}(21:40,1);
                
                %4
                %donneesApp{c}=[signauxParam{c}(61:100,1);signauxParam{c}(1:40,1)];
                %donneesTest{c}=signauxParam{c}(41:60,1);

                %5
                %donneesApp{c}=[signauxParam{c}(81:100,1);signauxParam{c}(1:60,1)];
                %donneesTest{c}=signauxParam{c}(61:80,1);

                

            

            % ici on ne s'es pas trompé, car mean fait la moyenne des vecteurs ligne dans une matrice et
            % on a ordonné exprès les donnees App dans la cellule (ie les cellule des vecteurs en 
            % colonne   
            % plutôt qu'en ligne) de sorte que la fonction cell2mat renvoie bien la bonne matrice
   
            

            listeMean{c}=mean(cell2mat([donneesApp{c}]));
            listeCov{c}=cov(cell2mat([donneesApp{c}]));
        end

%------------------KPPV-------------------------------%

    case 'KPPV'
       
        for c=1:L
            
                %1
                donneesApp{c}=signauxParam{c}(1:80,1);
                donneesTest{c}=signauxParam{c}(81:end,1);
           
                %2
                %donneesApp{c}=signauxParam{c}(21:100,1);
                %donneesTest{c}=signauxParam{c}(1:20,1);

                %3%
                %donneesApp{c}=[signauxParam{c}(41:100,1);signauxParam{c}(1:20,1)];
                %donneesTest{c}=signauxParam{c}(21:40,1);
                
                %4
                %donneesApp{c}=[signauxParam{c}(61:100,1);signauxParam{c}(1:40,1)];
                %donneesTest{c}=signauxParam{c}(41:60,1);

                %5
                %donneesApp{c}=[signauxParam{c}(81:100,1);signauxParam{c}(1:60,1)];
                %donneesTest{c}=signauxParam{c}(61:80,1);

                

        end
   
 

    otherwise
        error('methode de classification non pris en charge');


end


%--------------------RECONNAISSANCE-----------------------%


%matrice des scores
matScores=cell(10,10);

%liste des scores (utilis pour loi normale)
listeScore=[];

%resultat final, taux de reconnaissance
result=0;

%on initialise chaque terme à 0
for i=1:10
    for j=1:10
        matScores{i,j}=0;
    end
end



switch methodeClassif

%------------------LOI NORMALE------------------------%
    case 'loi normale'
        
        for c=1:L
            Ld=length(donneesTest{c});
            for numero=1:Ld 

                
                v=donneesTest{c}{numero};
                for c2=1:L
                    listeScore(c2)=score(listeMean{c2},listeCov{c2},v);
                end

                %on prend le argmin, ie la classe qui minimise le score
                [valmin,Iargmin] = min(listeScore);
        
                %la classe est reconnu comme classe k
                k=Iargmin;

                %on fait la matrice des scores
                matScores{c,k} = matScores{c,k}+1;
                
            end
        end








%------------------KPPV-------------------------------%

    case 'KPPV'
        %pour chaque vecteur de test, on inscrit sa distance
        %avec le vecteur en cours
        listeDistanceClasse=[];


        % pour chaque vecteur test...
        for c=1:L
            LTest=length(donneesTest{c});
            for numero=1:LTest           
                vTest=donneesTest{c}{numero};
                
                % on reinitialise la liste
                listeDistanceClasse=[];

                % et pour chaque vecteur d'apprentissage
                for c2=1:L
                    LApp=length(donneesApp{c2});
                    for numeroApp=1:LApp
                        vApp=donneesApp{c2}{numeroApp};

                        % on inscrit la distance entre les deux vecteurs.
                        % On utilise la distance euclidienne sans prendre la racine carrée, car on prend un max
                        distance=sum((vApp - vTest).^2);
                        listeDistanceClasse=[listeDistanceClasse;[distance,c2]];

                    end
                end 
                
                k=kval;

                listeDistanceClasseSort=sortrows(listeDistanceClasse,1);                

                

                listeDistanceClassek=listeDistanceClasseSort(1:k,2);
	
                              

	            [M,F,C]=mode(listeDistanceClassek);
	
	
	            while(length(C{1})>1 && k<800)
		
		            k=k+1;
		            listeDistanceClassek= listeDistanceClasseSort(1:k,2);
		            [M,F,C]=mode( listeDistanceClassek);
		            
		
		
	            end

                valeur{c}{numero}=listeDistanceClassek;  
	
	            classe = M;
                
                matScores{c,M} = matScores{c,M}+1;
                
                
 
            end
        end              
                    



   

        
    end
   
   

result= sum(diag(cell2mat(matScores)))/sum(sum(cell2mat(matScores)));


















%












