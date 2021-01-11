import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import peasy.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class cylindre extends PApplet {



PeasyCam cam;

float[][] terrain;

public void setup()
{
    
    cam = new PeasyCam(this, 500);
    lights();
    // noStroke();
    fill(100, 200, 0);
}

public void draw()
{
  background(255);
  pushMatrix();
  // translate(width/2,height/2);
  // rotateY(PI/3);
  drawCylinder(60, 200, 700);
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
  popMatrix();
}

public void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float yoff = 0;

    terrain = new float[sides+1][sides+1];
    for ( int j=0; j < sides; j++){
      float xoff = 0;
      for (int i=0; i < sides; i++){
        terrain[i][j] = map(noise(xoff,yoff), 0, 1, -300, 300); // on convertit la valeur de noise qui vaut entre 0 et 1 en une valeur entre -100 et 100
        xoff += 0.1f;
    }
    yoff += 0.2f;
    }
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for(int j = 0; j < sides; j++){
      for (int i = 0; i < sides; i++) {
          float x = cos( radians( i * angle ) ) * r;
          float y = sin( radians( i * angle ) ) * r;
          fill(i, j,(i+j/2));
          vertex( x + terrain[i][j], y + terrain[i][j], -h/2 + (j*h)/sides);
          vertex( x + terrain[i][j+1], y + terrain[i][j+1], -h/2 + ((j+1)*h)/sides);
      }
    }
      endShape();
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
