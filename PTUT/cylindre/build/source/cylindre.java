import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class cylindre extends PApplet {

public void setup()
{
    
    lights();
    fill(100, 200, 0);
}

public void draw()
{
    background(255);

    pushMatrix();
    translate(width/2,height/2);
    rotateY(PI/3);
    drawCylinder( 30, 100, 300 );
    popMatrix();

}

public void drawCylinder( int sides, float r, float h)
{
    PVector[][] tab = new PVector[sides+1][sides+1];
    float angle = 360 / sides;

    // draw sides
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < sides + 1; i++) {
        float x = cos( radians( i * angle ) ) * r;
        float y = sin( radians( i * angle ) ) * r;
        vertex( x, y, h/2);
        vertex( x, y, -h/2);
    }
    endShape(CLOSE);
    // for (int i = 0; i < sides + 1; i++) {
    //   for(int j = 0; j < sides + 1; j++)
    //   {
    //     float x = cos( radians( i * angle ) ) * r;
    //     float y = sin( radians( i * angle ) ) * r;
    //     tab[i][j] = new PVector(x,y,0);
    //   }
    // }
    //
    // for (int i = 0; i < sides + 1; i++) {
    //   beginShape(TRIANGLE_STRIP);
    //   for(int j = 0; j < sides; j++)
    //   {
    //     PVector v1 = tab[i][j];
    //     PVector v2  =tab[i][j+1];
    //     vertex(v1.x, v1.y, -h/2 + (j*h)/sides);
    //     vertex(v2.x, v2.y, -h/2 + ((j+1)*h)/sides);
    //   }
      endShape();
    //}


}
  public void settings() {  size(600, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "cylindre" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
