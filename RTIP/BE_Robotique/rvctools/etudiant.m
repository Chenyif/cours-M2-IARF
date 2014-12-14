% Mod�lisation du robot SCARA Mitsubishi

%% NE PAS MODIFIER CETTE PARTIE
clc
clear all
close all

% D�finition des param�tres g�om�triques du robot
a1 = 0.4; % Distance entre L1 et L2
a2 = 0.4; % Distance entre L2 et L3
L3 = 0.2; % Distance entre la cam�ra et la 3�me liaison (point O3)
h = 0.8;  % Hauteur au-dessus du plan de travail

% On d�finit ici 4 liaisons 3 rotoides et 1 prismatique (la 3�me) � l'aide
% des param�tres de Denavit/Hartenberg.
% Attention les param�tres de Denavit Hartenberg ne correspondent pas  aux
% conventions du cours
% theta d a alpha
L(1) = Link([ 0     0   a1  0], 'standard');
L(2) = Link([ 0     0   a2  0], 'standard');
L(3) = Link([ 0     0   0  0 1]);
L(4) = Link([ 0     0   0  0], 'standard');

% D�finition des limites physiques des axes
L(1).qlim = [-pi pi];
L(2).qlim = [-pi pi];
L(3).qlim = [-2 0];
L(4).qlim = [-pi pi];

% On d�finit ici notre robot comme la concat�nation des liaisons
% pr�c�dentes, on lui donne un nom, etc.
robot = SerialLink(L, 'name', 'Mitsubishi', ...
    'comment', 'from AIP');

%robot.teach() : ne pas utiliser cette m�thode car risque de bug

% FIN DE LA PARTIE NON MODIFIABLE

%%
% Diff�rentes configurations de test pour les MGD/MGI
q1 = zeros(1,4);
q2 = [pi/2 0 0 0];
q3 = [0 pi/2 0 0];
q4 = [0 0 0 pi/2];
q5 = [-pi/2 0 0 0];
q6 = [0 0 -0.5 0];
q7 = [-pi/2 pi/2 -0.5 0];

% Choix de la config de test parmi celles d�finies au-dessus
q = q1;

% Calcul du MGD � l'aide de la fonction pr�d�finie
robot.fkine(q)
% Affichage du robot pour la configuration q choisie
robot.plot(q)


%% Calcul du MGD

% A COMPLETER
% AFFICHER LA MATRICE DE PASSAGE ENTRE LE REPERE R0 ET LE REPERE OUTIL

disp('fkine pour q1')
robot.fkine(q)
disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q2;

disp('fkine pour q2')
robot.fkine(q)

disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q3;

disp('fkine pour q3')
robot.fkine(q)

disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q4;

disp('fkine pour q4')
robot.fkine(q)

disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q5;

disp('fkine pour q5')
robot.fkine(q)

disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q6;

disp('fkine pour q6')
robot.fkine(q)

disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q7;

disp('fkine pour q7')
robot.fkine(q)

disp('MGD calcule')

T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

q=q1;


T01= DenHart(0,0,0,q(1));
T12= DenHart(a1,0,0,q(2));
T23= DenHart(a2,0,q(3),0);
T34= DenHart(0,0,0,q(4));
T04=T01*T12*T23*T34

pause

%% Affichage sur la figure du rep�re cam�ra
% Calculer ici TOC la matrice de passage homog�ne entre R0 et Rc puis
% l'afficher sur la figure (commande trplot)


c1=cos(q(1));
s1=sin(q(1));
c2=cos(q(2));
s2=sin(q(2));

t1 = s1*s2-c1*c2;
t2 = -(c1*s2-c2*s1);
t3 = c2*(L3+a2)+a1;
t4 = s2*(L3+a2);

T0C=[ [t1 , t2 , 0 , c1*t3 - s1 * t4]; 
      [t2 , -t1, 0 , s1*t3 + c1 * t4];
      [0  , 0  ,-1 , 0              ];
      [0  , 0  , 0 , 1              ] ];


hold on % permet de superposer plusieurs courbes sur une seule figure
trplot(T0C,'frame', 'C') 

% A COMPLETER
 
 %% D�termination de la position et de l'orientation de la pi�ce dans R0
 
 % Mesures renvoy�es par la cam�ra : NE PAS MODIFIER
  PosPieceDsRc = [0.5;0;h;1]; % position pi�ce dans Rc
  thetaP = pi/2; % orientation pi�ce dans Rc
  
  % Calculer et afficher la position (X,Y,Z) de la pi�ce dans R0
  % A COMPLETER

  [
  %plot3(X,Y,Z,'ro'); % pour afficher
  
  % Calculer la position de l'objet dans R4 (rep�re outil)
  % A COMPLETER
  
  % En d�duire la matrice de passage T0P entre le rep�re R0 et l'objet
  % A COMPLETER
  
display('appuyer sur une touche')
pause

  %% Calcul des deux solutions du MGI
display('MGI')

% Qtot = ensemble des configurations solutions. Qtot est une matrice
% dont les colonnes sont d�finies par les 2 configurations solutions.

% A COMPLETER

EPS2 = 1; 
cq2 = 

for i=1:2
    Qtot(3,i) = 
    sq2 = 
    Qtot(2,i) = atan2(sq2,cq2);
    B1 = 
    B2 = 
    sq1 = 
    cq1 = 
    Qtot(1,i) = atan2(sq1,cq1);
    Qtot(4,i) = 
    EPS2=-1; 
end

% Affichage de la config obtenue et de la matrice de passage correspondante
display('MGD avec Q calcul� config 1')
robot.fkine(Qtot(:,1))
display('MGD avec Q calcul� config 2')
robot.fkine(Qtot(:,2))
% Affichage du robot config 1
robot.plot(Qtot(:,1)')
display('appuyer sur une touche')
pause
% Affichage du robot config 1
robot.plot(Qtot(:,2)')


%% Calcul d'une trajectoire entre la configuration initiale et celle � 
% atteindre pour l'outil

% Calcul de la trajectoire cas de la config 1
Q = Qtot(:,1)'; % D�finition de la configuration � atteindre
figure
robot.plot(q) % Affichage du robot � la configuration initiale
hold on
plot3(X,Y,Z,'ro'); % Affichage de la position de la pi�ce dans R0
t = [0:.05:10]; % Vecteur temps n�cessaire pour le calcul de la trajectoire
Traj_Q = jtraj(q,Q,t); % Calcul de la trajectoire
robot.plot(Traj_Q) % Affichage de la trajectoire

display('appuyer sur une touche')
pause
% calcul de la trajectoire cas de la config 2
Q = Qtot(:,2)';  % D�finition de la configuration � atteindre
figure
robot.plot(q) % Affichage du robot � la configuration initiale
hold on
plot3(X,Y,Z,'ro'); % Affichage de la position de la pi�ce dans R0
t = [0:.05:10]; % Vecteur temps n�cessaire pour le calcul de la trajectoire
Traj_Q = jtraj(q,Q,t); % Calcul de la trajectoire
robot.plot(Traj_Q)  % Affichage de la trajectoire


