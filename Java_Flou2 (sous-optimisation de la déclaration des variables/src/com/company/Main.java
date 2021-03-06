package com.company;

import javax.swing.*;

public class Main {

    public static void main(String[] args) {
        String filename;
        int looping = 5;
        if(args.length == 1)
        {

            System.out.println("No looping specified, applying blur 5 times by default");
            filename = args[0];

        } else if(args.length == 2)
        {
            filename = args[0];
            looping = Integer.valueOf(args[1]);

        }
        else
        {

            System.out.println("No image specified, taking tearsofsteel.jpg as default.");
            System.out.println("No looping specified, applying blur 5 times by default");
            filename = "tearsofsteel.jpg";
        }
        System.out.printf("File : %s, loops : %d\n", filename, looping);

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

        LoadImageApp ImageOrig = new LoadImageApp(filename);
        ImageOrig.toGray();
        Window1.add(ImageOrig);
        Window1.pack();
        Window1.setVisible(true);



        // 2nd window

        JFrame Window2 = new JFrame("Image floutée");

        Window2.setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);


        LoadImageApp ImageBlur = new LoadImageApp(filename);
        ImageBlur.toGray();

        long t0 = System.nanoTime();
        for (int i = 0; i < looping; i++) {
            ImageBlur.blur();
        }
        long t1 = System.nanoTime();

        Window2.add(ImageBlur);
        Window2.pack();
        Window2.setVisible(true);



        System.out.println("Elapsed time: " + (t1 - t0)/1E9 + " s");

    }
}