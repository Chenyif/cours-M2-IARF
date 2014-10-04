package p;

import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Scanner;

public class Main {

	public static void main(String[] args) {

		Company c = new Company("Nestlé");

		// Mentor mo1= new Mentor("Jean",5200,1000.f);
		// mo1.setLangage("C++");
		//
		// Mentee me2 = new Mentee("Vincent", 5201, 1000.f);
		// me2.setLangage("Java");
		//
		// //mentor de vincent est marc
		// //c.addEmploye(me2, mo);
		//
		// Mentee me3 = new Mentee("Camille", 5202, 1000.f);
		// me3.setLangage("Java");
		//
		// Mentor mo4 = new Mentor("Marc",5203,1210.f);
		// mo4.setLangage("Java");
		//
		//
		// c.addEmploye(mo1);
		//
		// c.addEmploye(me2);
		// c.addEmploye(me2,mo4);
		// c.addEmploye(me3,mo4);
		// c.addEmploye(mo4);
		//
		//
		//
		// c.displayEmployes();
		//
		//
		// mo1.display();
		// me2.display();
		// me3.display();
		// mo4.display();
		// si on veut lire à partir d'init.txt
		
		
		
		
		
		
		
		Main.lireinfo(c);
		Main.menu(c);

		/*
		 * c.displayEmployes();
		 * 
		 * c.displayReports("report.txt");
		 */
	}

	/** pour recuperer les infos à partir de init.txt */
	static void lireinfo(Company c) {

		// Company c = new Company("Nestlé");

		BufferedReader br = null;

		try {
			br = new BufferedReader(new FileReader("init.txt"));
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		}
		String ligne = null;
		String[] champs = null;
		String prenom = null;
		int numPay = 0;
		float salaryB;
		String langage;
		int numPayMentor = 0;
		Mentor e1 = null;
		Mentee e2 = null;

		try {
			while ((ligne = br.readLine()) != null) {

				champs = ligne.split(",");
				prenom = champs[0];
				numPay = Integer.parseInt(champs[1]);
				salaryB = Float.parseFloat(champs[2]);
				langage = champs[3];

				if (champs.length == 4) {
					e1 = new Mentor(prenom, numPay, salaryB);

					e1.setLangage(langage);
					c.addEmploye(e1);

				}

				else if (champs.length == 5) {

					e2 = new Mentee(prenom, numPay, salaryB);
					e2.setLangage(langage);

					numPayMentor = Integer.parseInt(champs[4]);

					e1 = (Mentor) c.findEmploye(numPayMentor);
					c.addEmploye(e2, e1);

				} else {
					System.out.println("nombre de champs incorects");
				}

			}

		} catch (IOException e) {

			e.printStackTrace();
		}

	}

	static void menu(Company c) {
		System.out.println("\nMENU\n");
		System.out.println("choisissez une commande (puis entree):\n");
		System.out.println("1: afficher les infos des employes");
		System.out.println("2: generer le raport (dans report.txt)");
		System.out
				.println("3: detail d'un employé (à partir de son num de paye)");
		System.out
				.println("4: modifier le langage spécialisé d'un employé (à partir de son numero de paie)");
		System.out.println("5: ajouter des employés");

		BufferedReader br = null;
		br = new BufferedReader(new InputStreamReader(System.in));
		int choix = 0;
		try {
			choix = Integer.parseInt(br.readLine());
		} catch (IOException e) {
			e.printStackTrace();
		}

		switch (choix) {
		case 1:
			c.displayEmployes();
			break;
		case 2:
			c.displayReports("report.txt");
			break;
		case 3:
			Main.infoEmploye(c);
			break;
		case 4:
			Main.setLangageEmploye(c);

		case 5:
			// TODO

		}
		try {
			System.out.println("appuyer sur entree pour continuer");
			br.readLine();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		Main.menu(c);

	}

	static void infoEmploye(Company c) {
		System.out.println("Entrez le numero de paye de l'employe");

		BufferedReader br = null;
		br = new BufferedReader(new InputStreamReader(System.in));
		int numPay = 0;
		try {
			numPay = Integer.parseInt(br.readLine());
		} catch (IOException e) {
			e.printStackTrace();
		}

		Employe e = null;
		e = c.findEmploye(numPay);
		if (e != null) {
			e.display();
		}

	}

	static void setLangageEmploye(Company c) {
		System.out.println("Entrez le numero de paye de l'employe");

		BufferedReader br = null;
		br = new BufferedReader(new InputStreamReader(System.in));
		int numPay = 0;
		try {
			numPay = Integer.parseInt(br.readLine());
		} catch (IOException e) {
			e.printStackTrace();
		}

		System.out.println("Entrez le nouveau langage");

		// br = new BufferedReader(new InputStreamReader(System.in));
		String langage = null;
		try {
			langage = br.readLine();
		} catch (IOException e) {
			e.printStackTrace();
		}

		Employe e = null;
		e = c.findEmploye(numPay);
		if (e != null) {
			e.setLangage(langage);
		}

	}
	
	static void addEmploye(Company c) {
		//TODO
		
		
	}

}
