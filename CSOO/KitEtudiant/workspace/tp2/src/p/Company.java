package p;

import java.util.HashSet;

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
		me.setMentor(mo);
		// TODO
		// rajouter Mentee dans les Mentee du Mentor
		// this.hsEmp.
	}

	public void displayEmployes() {
		// TODO
	}

	public void displayReports(String theFile) {
		// TODO
	}

	@Override
	public String toString() {
		return "Company [name=" + name + ", hsEmp=" + hsEmp + "]";
	}

}
