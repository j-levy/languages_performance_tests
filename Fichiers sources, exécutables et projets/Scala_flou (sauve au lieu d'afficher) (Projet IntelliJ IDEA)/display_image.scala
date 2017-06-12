import java.awt.image.BufferedImage
import java.awt.{Graphics2D,Color,Font,BasicStroke}
import java.awt.geom._

// Size of image
val size = (500, 500)

// create an image
val canvas = new BufferedImage(size._1, size._2, BufferedImage.TYPE_INT_RGB)

// get Graphics2D for the image
val g = canvas.createGraphics()

// clear background
g.setColor(Color.WHITE)
g.fillRect(0, 0, canvas.getWidth, canvas.getHeight)

// enable anti-aliased rendering (prettier lines and circles)
// Comment it out to see what this does!
g.setRenderingHint(java.awt.RenderingHints.KEY_ANTIALIASING, 
		   java.awt.RenderingHints.VALUE_ANTIALIAS_ON)

// draw two filled circles
g.setColor(Color.RED)
g.fill(new Ellipse2D.Double(30.0, 30.0, 40.0, 40.0))
g.fill(new Ellipse2D.Double(230.0, 380.0, 40.0, 40.0))

// done with drawing
g.dispose()

// write image to a file
javax.imageio.ImageIO.write(canvas, "png", new java.io.File("drawing.png"))
