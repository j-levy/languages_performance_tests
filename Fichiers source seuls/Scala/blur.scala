/**
  * Created by jonathan on 05/05/17.
  */

/**
  * Created by jonathan on 25/04/17.
  */

import java.io.File
import javax.imageio.ImageIO
import java.awt.image.BufferedImage
import java.awt.{Graphics2D,Color,Font,BasicStroke}
import javax.swing._


def toGray(origPic: BufferedImage) : BufferedImage = {
  val pic = new BufferedImage(origPic.getWidth, origPic.getHeight, BufferedImage.TYPE_BYTE_GRAY)
  val g = pic.getGraphics
  g.drawImage(origPic, 0, 0, null)
  g.dispose()
  return pic
}

def blur(img: BufferedImage) : BufferedImage = {
  // obtain width and height of image
  val w = img.getWidth
  val h = img.getHeight

  // create new image of the same size
  val out = new BufferedImage(w, h, BufferedImage.TYPE_BYTE_GRAY)
  var tmp = 0
  // apply blur
  for (x <- 1 until w - 1) {
    for (y <- 1 until h - 1) {
      tmp = 0
      for (ii <- -1 to 1) {
        for (jj <- -1 to 1) {
          tmp += (img.getRGB(x + ii, y + jj) & 0xff) / 9
        }
      }
      out.setRGB(x, y, tmp + (tmp << 8) + (tmp << 16))
    }
  }

  return out
}

def apply_blur() {
  // read original image, and obtain width and height
  val photo1 = ImageIO.read(new File("tearsofsteel.jpg"))

  var photo2 = toGray(photo1)


  val photo3 =  time{  for (p <- 1 until 5) {
      photo2 = blur(photo2)
    }
      photo2}

  // save image to file "test.jpg"
  ImageIO.write(photo3, "jpg", new File("output.jpg"))

/*
  val Window1 = new JFrame("Image d'origine")

  Window1.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE)
  Window1.
  Window1.pack()
  Window1.setVisible(true)
*/

}

def time[R](block: => R): R = {
  val t0 = System.nanoTime()
  val result = block    // call-by-name
  val t1 = System.nanoTime()
  println("Elapsed time: " + (t1 - t0)/1E9 + " s")
  result
}

apply_blur()
