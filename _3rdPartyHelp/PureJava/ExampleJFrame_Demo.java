import java.awt.*;
import javax.swing.JFrame;
import processing.core.*;

class Embedded_Demo extends PApplet {
    public boolean ok;

    public void setup() {
        size(500, 500, P2D);
        drawImpl();
        // Indicator to external program to show that the drawing process has finished.
        ok = true;
        noLoop();
    }
    public void drawImpl()  {
        stroke(50);
        fill(0,0,255);
        for (int i = 0; i < 10; i++) {
            translate(20, 20);
            rect(0,0,30,30);
        }
    }
}

public class ExampleJFrame_Demo extends JFrame {
    Embedded_Demo embed;

    public ExampleJFrame_Demo() {
        super("Embedded PApplet");
        setLayout(new BorderLayout());
        embed = new Embedded_Demo();
        embed.init();

        add(embed, BorderLayout.CENTER);
    }

    public static void main(String[] args) throws Exception {
        ExampleJFrame_Demo myFrame = new ExampleJFrame_Demo();
        myFrame.setResizable(true);
        myFrame.setSize(500,500);
        myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
        myFrame.pack();
        myFrame.setVisible(true);
    }

//~     public static void main(String[] args) throws Exception {
//~         javax.swing.SwingUtilities.invokeLater(new Runnable()
//~         {
//~             public void run()
//~             {
//~                 ExampleJFrame_Demo myFrame = new ExampleJFrame_Demo();
//~                 myFrame.setResizable(true);
//~                 myFrame.setSize(500, 500);
//~                 myFrame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
//~                 myFrame.pack();
//~                 myFrame.setVisible(true);
//~             }
//~         });
//~     }
}
