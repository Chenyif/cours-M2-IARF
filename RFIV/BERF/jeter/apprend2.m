% classes: nom de chaques classe
% listeM: liste des moyennes moyenne 
% listeC: liste des matrices de covariance
%les vecteurs sont des vecteurs colonnes
function [listeMean,listeCov] = apprend2(classes)

%initialisation


%liste des moyennes des classes
listeMean={};
%liste des matrices de variances/covariance des classes
listeCov={};

%on compte le nombre de classes
L = length(classes);


%pour chaque classe c, on recupere le vecteur moyenne
%et la matrice de covariance et ont les ajoute à listeM et listeC
for c=1:L
    
    %donnees d'apprentissage
    donneesApp=[];
    
    %on prend 80 pourcent des vecteurs pour l'apprentissage
    for numero=1:80
        %on recupere les donnees d'apprentissage (vecteur colone)
        %a partir du repertoire Signal
        v=['Signal/' classes{c} num2str(numero-1,'%.2d') '.wav'];
        s=wavread(v);
        
        %on effectue une transformée de Fourrier sur 32 fenetres
        %on obtient un vecteur colonne de dimension 32
        s=parametrisation_fft32(s);
        
        %on transpose le vecteur et on l'ajoute aux données d'apprentissage
        donneesApp=[donneesApp;s'];
        
    end
    
    %calcul de la moyenne et matrice covariance de la classe c
    mi=mean(donneesApp);
    ci=cov(donneesApp);
   
    %on fabrique la liste des moyennes
    listeMean{c}=mi;
    %on fabrique la liste des matrices de covariances
    listeCov{c}=ci;
    
end
