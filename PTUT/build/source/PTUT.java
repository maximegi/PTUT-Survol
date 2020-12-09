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

public class PTUT extends PApplet {

int cols, rows;
int scl = 20;
int w = 600;
int h = 600;

float[][] terrain;
float flying = 0.0f;

public void setup() {
  
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
}

public void draw(){
  flying -= 0.08f;

  float yoff = flying;
   for ( int y=0; y < rows; y++){
     float xoff = 0;
     for (int x=0; x <cols; x++){
       terrain[x][y] = 1000 * sin(atan((x+1)/(y+1)));//map(noise(xoff,yoff), 0, 1, -50, 50); // on convertit la valeur de noise qui vaut entre 0 et 1 en une valeur entre -100 et 100
       xoff += 0.1f;
     }
     yoff += 0.2f;
   }

 background(0);
 noStroke();
 fill(0,180,0);
 directionalLight(126, 126, 126, 0, 0, -2);
 ambientLight(90, 90, 90);

 translate(width/2, height/2+20);
 rotateX(PI/3);
 rotateZ(PI/3);
 translate(-w/2, -h/2);

 for ( int y=0; y < rows-1; y++){
   beginShape(TRIANGLE_STRIP);
   for (int x=0; x <cols; x++){
     vertex(x*scl, y*scl, terrain[x][y]);
     vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
   }
   endShape();
 }
}
  public void settings() {  size(1080, 720, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PTUT" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
