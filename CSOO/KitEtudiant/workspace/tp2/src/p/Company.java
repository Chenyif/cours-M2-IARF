package p;

import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashSet;
import java.util.Iterator;

public class Company {

	/** attributs */

	private String name; // nom de l'entreprise
	private HashSet<Employe> hsEmp = new HashSet<Employe>();

	/** methodes */

	// constructeurs
	public Company() {

	}

	public Company(String nom) {
		this.name = nom;
	}

	/** pour ajouter un employe à la liste */
	public void addEmploye(Employe emp) {

		this.hsEmp.add(emp);

	}

	public void addEmploye(Mentee me, Mentor mo) {
		this.hsEmp.add(me);
		this.hsEmp.add(mo);
		me.setMentor(mo);
		mo.addMentee(me);
	}

	public String getName() {
		return this.name;
	}

	public void displayEmployes() {
		System.out.println("Calcul des salaires mensuels des employés de "
				+ this.getName());
		Iterator<Employe> i = this.hsEmp.iterator();

		while (i.hasNext()) {
			i.next().display();
		}

	}

	public void displayReports(String theFile) {
		// ouverture du fichier
		// FileWriter f = new FileWriter("report.txt");
		PrintWriter fic = null;

		try {
			fic = new PrintWriter(new FileWriter(theFile));
		} catch (IOException e) {
			e.printStackTrace();
		}

		fic.println("Calcul des salaires mensuels des employés de "
				+ this.getName());
		Iterator<Employe> i = this.hsEmp.iterator();

		while (i.hasNext()) {
			i.next().displayReports(fic);
		}

		fic.close();

	}

	/** trouve un employe avec le numero de pay indique */
	public Employe findEmploye(int numPay) {

		Iterator<Employe> i = this.hsEmp.iterator();
		Employe e = null;

		while (i.hasNext()) {
			e = i.next();
			if (e.getNum() == numPay) {
				return e;
			}
		}

		System.out.println("Aucun employé ne correspond au numero " + numPay);
		return null;
	}

}
