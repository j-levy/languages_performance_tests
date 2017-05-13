package com.company;

import java.awt.event.*;
import javax.swing.*;

public class Main {

    public static void main(String[] args) {

        JFrame Window1 = new JFrame("Image d'origine");

        Window1.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        /*
        // Alternatively, exit whole program when any window is closed !
        Window1.addWindowListener(new WindowAdapter(){
            public void windowClosing(WindowEvent e) {
                System.exit(0);
            }
        });
        */

        LoadImageApp ImageOrig = new LoadImageApp();
        ImageOrig.toGray();
        Window1.add(ImageOrig);
        Window1.pack();
        Window1.setVisible(true);



        // 2nd window

        JFrame Window2 = new JFrame("Image floutée");

        Window2.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);


        LoadImageApp ImageBlur = new LoadImageApp();
        ImageBlur.toGray();

        long t0 = System.nanoTime();
        ImageBlur.blur();
        long t1 = System.nanoTime();

        Window2.add(ImageBlur);
        Window2.pack();
        Window2.setVisible(true);



        System.out.println("Elapsed time: " + (t1 - t0)/1E9 + " s");

    }
}
