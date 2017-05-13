package com.company;


import java.awt.*;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.image.*;
import java.io.*;
import javax.imageio.*;
import javax.swing.*;


/**
 * This class demonstrates how to load an Image from an external file
 */
public class LoadImageApp extends Component {

    BufferedImage img;

    public void paint(Graphics g) {
        g.drawImage(img, 0, 0, null);
    }

    public LoadImageApp() {
        try {
            img = ImageIO.read(new File("tearsofsteel_low.jpg"));
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

    public void toGray(){
        BufferedImage pic = new BufferedImage(img.getWidth(), img.getHeight(), BufferedImage.TYPE_BYTE_GRAY);
        Graphics  g = pic.getGraphics();
        g.drawImage(img, 0, 0, null);
        g.dispose();
        img = pic;
    }

    public void blur() {
        // obtain width and height of image
        int w = img.getWidth();
        int h = img.getHeight();

        // create new image of the same size
        BufferedImage out = new BufferedImage(w, h, BufferedImage.TYPE_BYTE_GRAY);
        int tmp = 0;
        // apply blur
        int x,y,ii,jj;
        for (x = 1; x < w - 1; x++) {
            for (y = 1; y < h - 1; y++) {
                tmp = 0;
                for (ii = -1; ii <= 1; ii++) {
                    for (jj = -1; jj <= 1; jj++) {
                        tmp += (img.getRGB(x + ii, y + jj) & 0xff) / 9;
                    }
                }
                out.setRGB(x, y, tmp + (tmp << 8) + (tmp << 16));
            }
        }

        img = out;
    }


}