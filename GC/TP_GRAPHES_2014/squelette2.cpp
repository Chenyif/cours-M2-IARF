#include <iostream>
#include <fstream>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <vector>
#include <ctime>
#include <limits.h>

using namespace std;

/*-----------------------------------------------------------------------------*/
class Activity
        /*-----------------------------------------------------------------------------*/
{
public:
    /*==========================================*/
    /*=                ATTRIBUTS               =*/
    /*==========================================*/
    int i,n_p,n_s; // No de l'activit et nombre de prdecesseurs et successeurs
    int di_max,di_min; // Dure max et min de l'activit
    vector <int> Pred; // Liste des prdecesseurs
    vector <int> Succ; // Liste des successeurs

    /*==========================================*/
    /*=                METHODES                =*/
    /*==========================================*/
    Activity(void) // Constructeur
    {
        i=-1; di_max=0; di_min=0; n_p=0;n_s=n_p=0;
    };
    ~Activity(void) // Destructeur
    {};
    void AddPred(int i) // Ajoute i dans la liste des prdecesseurs de la tche
    {
        n_p++;Pred.push_back(i);
    };
    friend ostream & operator << (ostream &f, Activity *a) // Affichage des caractristiques de la tche
    {
        f<<"Activity "<<a->i<<" with duration ["<<a->di_min<<", "<<a->di_max<<"], having "<<a->n_p<<" predecessor(s) (";
        vector<int>::iterator it;
        for(it=a->Pred.begin();it<a->Pred.end();it++)
            f<<*it<<" ,";
        f<<") and "<<a->n_s<<" successor(s) (";
        for(it=a->Succ.begin();it<a->Succ.end();it++)
            f<<*it<<" ,";
        f<<")\n";
        f.flush();
        return f;
    };
};

class ActivityGraph
{
public:
    /*==========================================*/
    /*=                ATTRIBUTS               =*/
    /*==========================================*/
    vector <Activity> A; // Liste des activits sommets
    /*==========================================*/
    /*=                METHODES                =*/
    /*==========================================*/
    ActivityGraph(char *filename,int coef)  // Constructeur
    {
        filebuf fichier;
        filebuf *ouvert=fichier.open(filename,ios_base::in);
        if(!ouvert)
        {
            cout<<"Can not open file "<<filename<<endl;
            exit(1);
        }
        istream entree(&fichier);
        int n_activites;
        entree>>n_activites;
        A.resize(n_activites);
        for(int i=0;i<n_activites;i++)
        {
            float di_max,di_min;
            entree>>A[i].i;
            entree>>di_min;
            entree>>di_max;
            entree>>A[i].n_s;
            A[i].di_max=(int)floor(di_max*coef);
            A[i].di_min=(int)floor(di_min*coef);
            A[i].Succ.resize(A[i].n_s);
            for(int j=0;j<A[i].n_s;j++)
            {
                entree>>A[i].Succ[j];
                A[A[i].Succ[j]].AddPred(i);
            }
        }
    };
    friend ostream & operator << (ostream &f, ActivityGraph *G) // Affichage du graphe
    {
        int n=G->A.size();
        f<< "The graph has "<<n<<" activities :\n";
        for(int i=0;i<n;i++)
            f<<&(G->A[i]);
        f.flush();
        return f;
    };









    /*                          tri topologique                    */
    /*-------------------------------------------------------------*/
    vector <int> DFS()
    {
        
        //liste des numeros des sommets triés
        vector <int> tri;


        //Liste indiquant les noeuds visite
        bool *visited = new bool[A.size()];

        //initialisation de visited
        for(int i=0;i<A.size();i++){
            visited[i]=false;
        }

        //pile des activites en cours de visite
        vector <Activity> pile;

        //Acitivite courante
        Activity activiteCourante;

        //on part du sommet
        activiteCourante = A[0];

        int i=0;

        //on rjoute l'activite a la pile
        pile.push_back(activiteCourante);

        cout << "\n";

        //à faire tant que la pile n'est pas vide
        do
        {


            //tant qu'il y a des successeurs au noeud courant

            i=0;
            //pour chaque successeur de l'activite courante
            while(i<activiteCourante.n_s){

                //si le successeur n'est pas visite
                if(!visited[(activiteCourante.Succ).at(i)]){


                    //on le visite
                    activiteCourante=A.at(activiteCourante.Succ.at(i));

                    //on rajoute ce successeur a la liste des noeuds en cours de visite
                    pile.push_back(activiteCourante);

                    //et on reinitialise le numero des successeurs a visite
                    i=0;
                }
                else{
                    i++;
                }
            }

            //tous les successeurs sont visites ou il n'y a plus de successeur

            //l'activite courante est donc visite
            visited[activiteCourante.i] = true;

            tri.insert(tri.begin(),activiteCourante.i);

            //on retire le sommet visite de la pile des sommets restants
            pile.pop_back();

            //si la pile n'est pas vide, le sommet en cours est le dernier élément inséré
            if(!pile.empty()){
                activiteCourante=pile.back();
            }

        }while(!pile.empty());

        // si la pile est vide, le parcours est fini


        return tri;

    }





    /*                          chemin optimiste                   */
    /*-------------------------------------------------------------*/

    /* question 1.c = determine la longueur du chemin optimiste le plus court entre s et chacun de ses sommets*/
    vector <int> longueurCheminOpti(){

        /*ltt est la liste du tri topologique*/
        vector <int> ltt = this->DFS();

        //liste des distances de s à chaque sommet
        vector <int> liste_longueur;

        //on initialise toutes les longueurs a l'infini
        for(int i=0;i<A.size();i++){
            liste_longueur.push_back(INFINITY);
        }

        //sommet en cours de traitement
        int sActu;

        /* la longueur du chemin entre la source et elle-même est sa durée minimum */
        liste_longueur[0] = 0;


        //pour chaque sommet
        for(int i=0;i<ltt.size();i++){
            sActu=ltt[i];
            for(int numSucc=0; numSucc < A.at(sActu).n_s;numSucc++){

                //si on ameliore la distance on remplace la nouvelle valeur
                if(A[sActu].di_min + liste_longueur[sActu]<liste_longueur[(A[sActu].Succ).at(numSucc)]){
                    liste_longueur[(A.at(sActu).Succ).at(numSucc)] = A[sActu].di_min + liste_longueur[sActu];
                }
            }

        }

        return liste_longueur;

    }

    /*                          chemin pessimiste                  */
    /*-------------------------------------------------------------*/
    vector <int> longueurCheminPessi(){

        /*ltt est la liste du tri topologique*/
        vector <int> ltt = this->DFS();

        //liste des distances de s à chaque sommet
        vector <int> liste_longueur;

        //on initialise toutes les longueurs a l'infini
        for(int i=0;i<A.size();i++){
            liste_longueur.push_back(INFINITY);
        }

        //sommet en cours de traitement
        int sActu;

        /* la longueur du chemin entre la source et elle-même est sa durée minimum */
        liste_longueur[0] = 0;



        for(int i=0;i<ltt.size();i++){
            sActu=ltt[i];
            for(int numSucc=0; numSucc < A.at(sActu).n_s;numSucc++){

                //si on ameliore la distance on remplace la nouvelle valeur
                if(A[sActu].di_max + liste_longueur[sActu]<liste_longueur[(A[sActu].Succ).at(numSucc)]){
                    liste_longueur[(A.at(sActu).Succ).at(numSucc)] = A[sActu].di_max + liste_longueur[sActu];
                }
            }

        }

        return liste_longueur;

    }



    /*                liste des chemins de s a t                   */
    /*-------------------------------------------------------------*/
    vector< vector<int> > toutChemin(){

        //tous les chemins possibles de s à t
        vector< vector<int> > allPath;

        //chemin courant
        vector<int> pathRunning;

        // activite courante
        Activity activiteCourante;

        //on part de la source
        activiteCourante = A[0];

        //on concatene a allPath tous les chemins descendant du sommet
        //0 dans l'algorithme de recherche en profondeur
        allPath = recChemin(allPath,pathRunning,activiteCourante);

        return allPath;


    }
    /*               algo recursif pour recherche de chemin        */
    /*-------------------------------------------------------------*/

    //renvoie l'esemble des chemins déja calculé concaténé avec ceux partant de
    //l'activité courante
    vector< vector<int> > recChemin(vector< vector<int> > allPath,vector<int> pathRunning, Activity activiteCourante){


        //on ajoute l'activite courante au chemin en cours
        pathRunning.push_back(activiteCourante.i);



        //si on tombe sur le puit, on ajoute le chemin à allPath
        if(activiteCourante.i == A.size()-1){

            allPath.push_back(pathRunning);
        }

        //sinon, on continue la recherche en profondeur pour chaque successeur
        else{

            for(int i=0;i<activiteCourante.Succ.size();i++){
                //on concatene a allPath tous les chemins descendant du sommet
                //courant dans l'algorithme de recherche en profondeur
                allPath = recChemin(allPath,pathRunning,A[activiteCourante.Succ.at(i)]);

            }
        }
        return allPath;
        //on devrait enlever le sommet traité en fisant
        //pathRunning.pop_back();
        //mais ici on a pas besoin car la variable pathRunning est une variable locale
        //elle disparaitra simplement

    }





    /*               algo pour calculer le regret d'un chemin      */
    /*-------------------------------------------------------------*/

    int Regret(vector< vector<int> > allPath,int numChemin){

        //on initialise le regret a l'infini
        int Reg = INFINITY;
        //regret auxiliaire
        int RegAux;

        //cout du chemin
        int coutChemVoulu = 0;

        int listeCouts [A.size()];
        //on initialise toutes les distances à dmin
        for(int i=0;i<A.size();i++){
            listeCouts[i]=A[i].di_min;


        }

        //on choisi le chemin voulu
        vector<int> cheminVoulu = allPath[numChemin];

        //on met les distances contenu dans le chemin à d max
        for(int i=0;i<cheminVoulu.size();i++){
            listeCouts[cheminVoulu[i]]=A[cheminVoulu[i]].di_max;
            //on en profitte pour calculer le cout du chemin voulu
            coutChemVoulu=coutChemVoulu+A[cheminVoulu[i]].di_max;
        }

        //on calcule le cout des chemins un à un, si un est inférieur
        //a l'autre on le garde pour avoir le plus court chemin
        for(int i=0;i<allPath.size();i++){

            RegAux=0;
            //on ajoute à regAux tous les couts
            for(int j=0;j<allPath[i].size();j++){

                RegAux=RegAux+listeCouts[allPath[i][j]];

            }


            //si on a trouve un chemin plus court, on change RegAux
            if(RegAux<Reg){
                Reg=RegAux;
            }


        }
        //le regret est egale au cout du chemin - le plus court chemin
        return coutChemVoulu-Reg;


    }
    /*     fonction qui renvoi le chemin robuste et le regret      */
    /*-------------------------------------------------------------*/
    void chRobusteMinRegret(vector< vector<int> > allPath, int& chem,int& reg){

        int minReg=INFINITY;
        int regAux=0;
        int chemin=INFINITY;

        //pour chaque chemin
        for(int i=0;i<allPath.size();i++){
            //on calcule le regret
            regAux=Regret(allPath,i);
            //on garde le plus petit regret ainsi que le chemin associe
            if(regAux < minReg){
                minReg=regAux;
                chemin=i;
            }

        }
        //on renvoi le chemin et le regret
        chem=chemin;
        reg=minReg;

    }



    /*     fonction qui affiche le regret pour chaque chemin       */
    /*-------------------------------------------------------------*/
    void afficheRegrets(vector< vector<int> > allPath){

        for(int i=0;i<allPath.size();i++){

            cout << "regret " << i << " "<< Regret(allPath,i)<<endl;

        }
    }

    /*fonction qui renvoie tout les chemins de s à t passant par l'activité numAct*/
    /*                    à partir de tous les chemins possibles                  */
    /*----------------------------------------------------------------------------*/

    vector< vector<int> > toutCheminPassantPar(vector< vector<int> > allPath,int numAct){
        int i=0;
        while(i<allPath.size()){
            //si l'activité numAct n'appartient pas au chemin
            if(!belongInt(allPath[i],numAct)){
                //on la supprime
                allPath.erase(allPath.begin()+i);

            }
            //sinon
            else{
                i++;
            }

        }
        return allPath;

    }



    /*fonction pour savoir si un entier appartient à un vecteur d'entier*/
    /*------------------------------------------------------------------*/
    bool belongInt(vector<int> v,int elem){

        for(int i=0;i<v.size();i++){
            if(v[i] == elem){
                return true;
            }

        }
        return false;
    }


    /*fonction pour afficher le chemin robuste et le regret correspondant*/
    /*pour tous les chemins passant par chaque activité i                */
    /*-------------------------------------------------------------------*/
    //fait avec la notion de regret de possibilite 1

    void chemRobRegPassntPar(vector< vector<int> > allPath){
        //liste des chemins passant par i
        vector< vector<int> > allPathByi;
        //pour chaque activite

        for(int i=0;i<A.size();i++){
            //on recupere la liste des chemins passant par i
            allPathByi = toutCheminPassantPar(allPath,i);
            int chem;
            int reg;
            //parmis ces chemins on choisis le chemin robuste et on calcule son regret
            chRobusteMinRegret(allPathByi, chem,reg);
            cout<< "chemin robuste passant par " <<i << endl;

            afficheIntVector(allPathByi[chem]);
            cout << "regret associe: "<< reg <<endl;


        }


    }


    /*   algo pour calculer les regrets de tous les chemins        */
    /*-------------------------------------------------------------*/

    vector<int> regrets(vector< vector<int> > allPath){
        vector <int> regrets;

        for(int i=0;i<allPath.size();i++){


            regrets.push_back(Regret(allPath,i));


        }
        return regrets;

    }

    /* algo pour afficher le regret du chemin robuste de tous les chemins passant par act */
    /*------------------------------------------------------------------------------------*/


    void regretsPassantPar(vector< vector<int> > allPath,int act){
        vector <int> vRegrets;
        int reg=INFINITY;
        int chem;

        vRegrets=regrets(allPath);



        int i=0;
        while(i<allPath.size()){
            //si l'activité act n'appartient pas au chemin
            if(!belongInt(allPath[i],act)){
                //on l'enlève
                allPath.erase(allPath.begin()+i);
                vRegrets.erase(vRegrets.begin()+i);

            }
            //sinon
            else{
                //si l'activité appartient au chemin, et que ce chemin
                //a amélioré le regret, on garde ce chemin
                if(vRegrets[i] < reg){
                    reg=vRegrets[i];
                    chem=i;
                }

                i++;
            }


        }
        cout << "chemin robuste entre s et t passant par " << act <<endl;
        afficheIntVector(allPath[chem]);
        cout << "regret " << vRegrets[chem]<<endl;


    }

    /* algo pour afficher le regret et le chemin robuste des chemins passant par chaque activite*/
    /*------------------------------------------------------------------------------------------*/
    //fait avec la notion de regret de possibilite 2


    void tousRegrets(vector< vector<int> > allPath){


        //pour chaque activite
        for(int i=0;i<A.size();i++){
            //affiche les infos
            regretsPassantPar(allPath,i);
        }
    }





    //pour afficher un vecteur d'entier
    void afficheIntVector(vector<int> v){

        for(int i = 0; i < v.size();i++){

            cout << "v[" << i << "] ";
            cout << v.at(i) << " ";

        }
        cout << endl;

    }
    //pour afficher un vecteur de vecteur d'entier
    void afficheIntVectorVector(vector< vector<int> > v){
        for(int i = 0; i < v.size();i++){

            cout << "vecteur[" << i << "]" << endl;
            afficheIntVector(v.at(i));

        }

    }





};






int main(int argc, char **argv)
{


    if(argc<2 || argc >3)
    {
        cout<<" The syntax must respect the following format: main.exe <Problem_file> {< Duration_multiplicator=1>} \n";
        return 0;
    }
    int Duration_mul=1;
    if(argc==3)
        Duration_mul=atoi(argv[2]);
    char fileName[60];
    strcpy(fileName,argv[1]);
    clock_t start=clock(); // Lancement du cpt TCdi_max
    ActivityGraph G(fileName,Duration_mul);


    //seance 1
    /*
    vector <int> tri = G.DFS();

    cout << "tri topologique" << endl;
    G.afficheIntVector(tri);

    cout << endl;
    cout << "chemin opti";
    vector <int> lco =G.longueurCheminOpti();

    G.afficheIntVector(lco);
    cout << endl;
    cout << "chemin pessi";
    vector <int> lcp =G.longueurCheminPessi();

    G.afficheIntVector(lcp);

    cout << endl;

    */



    //seance 2


    /*possibilite 1*/
    /*
    vector< vector<int> > allPath;

    allPath=G.toutChemin();


    G.chemRobRegPassntPar(allPath);
    */




    /*possibilite 2*/
    /*
    vector< vector<int> > allPath;

    allPath=G.toutChemin();

    //G.afficheIntVectorVector(allPath);

    G.tousRegrets(allPath);
    */

    /*Affichage du chemin robuste et du regret associé*/

    vector< vector<int> > allPath;

    allPath=G.toutChemin();
    int chem;
    int min;

    G.chRobusteMinRegret(allPath,chem,min);

    cout << "chemin robuste " ;

    G.afficheIntVector(allPath[chem]);

    cout << "regret " << min<<endl;

    cout << endl;




    clock_t end=clock(); // Lancement du cpt TCdi_max
    cout<<"*===================================================================*\n";
    cout<<"Instance "<< fileName<<" done: Tcpu(microsec)="<<((double)(end - start) / (double)(CLOCKS_PER_SEC / 1000000.0))<<endl;
    cout<<"*===================================================================*\n";

    //    int coeff=100;
    //    cout << (int) (floor((float)3.78 *coeff));

    return 0;
}


