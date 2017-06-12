package com.company;


import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import javax.swing.*;


/**
 * Cette classe charge une image externe, et dispose de méthodes pour appliquer un flou et la passer en niveaux de gris.
 */
public class LoadImageApp extends Component {

	// L'image est chargée dans une classe BufferedImage
    BufferedImage img;

    public void paint(Graphics g) {
        g.drawImage(img, 0, 0, null);
    }

	// A la création d'un objet de type LoadImageApp, on lit le fichier avec ImageIO.read et on teste si l'ouverture a bien marché
    public LoadImageApp(String filename) {
        try {
            img = ImageIO.read(new File(filename));
        } catch (IOException e) {
            System.out.println("Exception caught : cannot load image.");
        }

    }

    public Dimension getPreferredSize() {
        if (img == null) {
            return new Dimension(100,100);
        } else {
            return new Dimension(img.getWidth(null), img.getHeight(null));
        }
    }

	// Conversion en niveaux de gris
    public void toGray(){
        BufferedImage pic = new BufferedImage(img.getWidth(), img.getHeight(), BufferedImage.TYPE_BYTE_GRAY);
        Graphics  g = pic.getGraphics();
        g.drawImage(img, 0, 0, null);
        g.dispose();
        img = pic;
    }

    public void blur() {
        // On récupère la taille de l'image
        int w = img.getWidth();
        int h = img.getHeight();

        // On crée une nouvelle image de la même taille
        BufferedImage out = new BufferedImage(w, h, BufferedImage.TYPE_BYTE_GRAY);
        int tmp = 0;
        // On applique le flou par convolution de matrice 3x3
        int x,y,ii,jj;
        for (x = 1; x < w - 1; x++) {
            for (y = 1; y < h - 1; y++) {
                tmp = 0;
                for (ii = -1; ii <= 1; ii++) {
                    for (jj = -1; jj <= 1; jj++) {
                        tmp += (img.getRGB(x + ii, y + jj) & 0xff) / 9; // le masque binaire 0xff est nécessaire pour les images en niveaux de gris (dû à la manière d'encoder les images par ImageIO dans Java)
                    }
                }
                out.setRGB(x, y, tmp + (tmp << 8) + (tmp << 16)); // écriture du niveau de gris
                // En fait, tmp contient une valeur de niveau de gris qu'on écrit aux 3 endroits de l'image avec setRGB :
                // On écrit la même valeur pour les teintes Rouge, Vert, Bleu en opérant un décalage binaire de 8 bits et 16 bits pour atteindre les bonnes zones de stockage de l'information. Ceci est encore dû à la manière de représenter les images avec ImageIO.
            }
        }

        img = out;
    }


}
