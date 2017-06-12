package com.company;

import javax.swing.*;

public class Main {

	
    public static void main(String[] args) {
        String filename;
        int looping = 5;
        
        /*
        Sans arguments, le programme exécute 5 flous sur l'image appelée "tearsofsteel.jpg".
        1er argument possible : un nombre, donnant le nombre de flous à appliquer
        2e argument possible : un nom de fichier image sur lequel appliquer les flous.
        */
        if(args.length == 1)
        {
            System.out.println("Pas de paramètre de nombre de flous à exécuter, applique 5 flous par défaut\n");
            filename = args[0];

        } else if(args.length == 2)
        {
            filename = args[0];
            looping = Integer.valueOf(args[1]);

        }
        else
        {

            System.out.println("Pas d'image spécifiée, utilise tearsofsteel.jpg par défaut\n");
            System.out.println("Pas de paramètre de nombre de flous à exécuter, applique 5 flous par défaut\n");
            filename = "tearsofsteel.jpg";
        }
        System.out.printf("Fichier : %s, Nombre de flous : %d\n", filename, looping);

		// Crée une première fenêtre pour afficher l'image d'origine.
        JFrame Window1 = new JFrame("Image d'origine");

        Window1.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        /*
        // Autrement, peut fermer le programme complet sur fermeture d'une fenêtre
        Window1.addWindowListener(new WindowAdapter(){
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        */

		// Charge l'image d'origine
        LoadImageApp ImageOrig = new LoadImageApp(filename);
        ImageOrig.toGray(); // conversion en niveaux de gris
        // Afficher l'image
        Window1.add(ImageOrig);
        Window1.pack();
        Window1.setVisible(true);



        // 2eme fenêtre pour l'image floutée

        JFrame Window2 = new JFrame("Image floutée");

        Window2.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);

		// Chargement de l'image pour la flouter
        LoadImageApp ImageBlur = new LoadImageApp(filename);
        ImageBlur.toGray();

		// Application des flous. Chronométrage. avec System.nanoTime()
        long t0 = System.nanoTime();
        for (int i = 0; i < looping; i++) {
            ImageBlur.blur();
        }
        long t1 = System.nanoTime();

		// on affiche l'image
        Window2.add(ImageBlur);
        Window2.pack();
        Window2.setVisible(true);
        
        // On affiche dans la console d'exécution le temps mis pour le flou
        System.out.println("Temps d'exécution des flous : " + (t1 - t0)/1E9 + " s");

    }
}
