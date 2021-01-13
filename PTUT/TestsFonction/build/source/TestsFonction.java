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

public class TestsFonction extends PApplet {



//PeasyCam cam;

PGraphics pgPlanarView, pgMappedView;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

float flying = 0;

float[][] terrain;

public void setup() {
  
  //cam = new PeasyCam(this, 500);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];

  pgPlanarView = createGraphics(width/2,height, P3D);
  pgMappedView = createGraphics(width/2,height, P3D);
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

  drawPlanar(pgPlanarView, cols, rows, terrain);
  mapCylinder(pgMappedView, cols, rows, 100, terrain);

  image(pgPlanarView, 0,0);
  image(pgMappedView, width/2,0);
}
public void drawPlanar(PGraphics pg, int cols, int rows, float[][]terrain){
  pg.beginDraw();
  pg.translate(width/4,height/2);
  pg.background(100);
  pg.stroke(255, 0, 0);
  pg.line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  pg.stroke(0, 255, 0);
  pg.line(0, -1000, 0, 0, 1000, 0);
  //z axis
  pg.stroke(0, 0, 255);
  pg.line(0, 0, -1000, 0, 0, 1000);
  pg.stroke(255);
  pg.noFill();

  pg.noStroke();
  pg.fill(0,180,0);
  pg.directionalLight(102, 202, 186, 1, 1, 0);
  pg.ambientLight(30, 30, 30);

  for(int j = 0; j < rows-1; j++)
  {
    pg.beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //cartesian coordinates
        float x = i;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = terrain[i][j];
        //z future
        float zf = terrain[i][j+1];

        //triangle vertices
        pg.vertex( x, yp, zp);
        pg.vertex( x,  yf, zf);
    }
    pg.endShape();
  }
  pg.endDraw();
}

public void mapCylinder(PGraphics pg, int cols, int rows, int rayon, float[][]terrain){
  pg.beginDraw();
  pg.translate(width/4,height/2);
  pg.background(0);
  pg.stroke(255, 0, 0);
  pg.line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  pg.stroke(0, 255, 0);
  pg.line(0, -1000, 0, 0, 1000, 0);
  //z axis
  pg.stroke(0, 0, 255);
  pg.line(0, 0, -1000, 0, 0, 1000);
  pg.stroke(255);
  pg.noFill();

  pg.noStroke();
  pg.fill(0,180,0);
  pg.directionalLight(102, 202, 186, 1, 1, 0);
  pg.ambientLight(30, 30, 30);

  //we're working with a half cylinder
  float angle = 180.0f / cols;

  for(int j = 0; j < rows-1; j++)
  {
    pg.beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //convert coordinate to cylinderspace
        float x = cos( radians( i * angle ) ) * rayon;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = sin( radians( i * angle ) ) * (rayon + terrain[i][j]);
        //z future
        float zf = sin( radians( i * angle ) ) * (rayon + terrain[i][j+1]);
        //triangle vertices
        pg.vertex( x, yp, zp);
        pg.vertex( x,  yf, zf);
    }
    pg.endShape();
  }
  pg.endDraw();
}
  public void settings() {  size(1920, 1080, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "TestsFonction" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
