package p;

import java.io.PrintWriter;

public abstract class Employe {

	/** attributs */

	String nom;
	int num;
	float salaryBase;
	String langage = "";

	/** methodes */

	Employe(String nom, int num, float salaryB) {

		this.nom = nom;
		this.num = num;
		this.salaryBase = salaryB;

	}

	Employe() {

	}

	/** pour mettre à jour la specialité du langage de l'Employe */
	public void setLangage(String langage) {
		this.langage = langage;
	}

	/** pour acceder au langage */

	public String getLangage() {
		return this.langage;
	}

	/** pour acceder au numero de paiement */

	public int getNum() {
		return this.num;
	}

	/** pour acceder au salaire de base */
	public float getSalaryB() {
		return this.salaryBase;
	}

	/** pour acceder au nom */
	public String getName() {
		return this.nom;
	}

	/** pour afficher les infos d'un employe */
	public void display() {
		System.out.println("Numéro de paie : " + this.getNum());
		System.out.println("Langage : " + this.getLangage());
		System.out.println("Salaire de base : " + this.getSalaryB());
	};
	
	public void displayReports(PrintWriter fic) {
		fic.println("Numéro de paie : " + this.getNum());
		fic.println("Langage : " + this.getLangage());
		fic.println("Salaire de base : " + this.getSalaryB());
		
	}

	/** pour calculer le bonus */
	abstract public int bonus();

	/** pour calculer le salaire */
	abstract public float getSalary();


	

}
