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

public class Plan extends PApplet {



PeasyCam cam;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

float flying = 0;

float[][] terrain;

public void setup() {
  
  cam = new PeasyCam(this, 500);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}

public void draw() {
  //up arrow fly
  if (keyCode == UP)
  {
    flying-=0.01f;
  }
  //down arrow reverse fly
  else if (keyCode == DOWN)
  {
    flying+=0.01f;
  }
  float xoff = flying;
  for (int x = 0; x < cols; x++)
  {
    float yoff = 0;
    for (int y = 0; y < rows; y++)
    {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -20, 20);
      yoff += 0.01f;
    }
    xoff += 0.01f;
  }

  background(0);
  //x axis
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  //z axis
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
  stroke(255);
  noFill();

  noStroke();
  fill(0,180,0);
  directionalLight(102, 202, 186, 1, 1, 0);
  ambientLight(30, 30, 30);


  float angle = 180.0f / cols;
  int r = 100;
  for(int j = 0; j < rows-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //cartesian coordinates
        // float x = i;
        // //y past
        // float yp = j;
        // //y future
        // float yf = j+1;
        // //z past
        // float zp = terrain[i][j];
        // //z future
        // float zf = terrain[i][j+1];

        //convert coordinate to cylinderspace
        float x = cos( radians( i * angle ) ) * r;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = sin( radians( i * angle ) ) * r + terrain[i][j];
        //z future
        float zf = sin( radians( i * angle ) ) * r + terrain[i][j+1];
        //triangle vertices
        vertex( x, yp, zp);
        vertex( x,  yf, zf);
    }
    endShape();
  }
}
  public void settings() {  size(1920, 1080, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Plan" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
