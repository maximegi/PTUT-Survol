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

public class cylindreTexture extends PApplet {



PeasyCam cam;

float[][] terrain;
float[][] textureMap;

PImage textureImg, textureImg2;

public void setup()
{
    
    textureImg = loadImage("texture_terrain.jpg");
    textureImg2 = loadImage("texture_2.jpg");
    cam = new PeasyCam(this, 200);
    lights();
    //fill(100, 200, 0);
}

public void draw()
{
  background(255);
  pushMatrix();
  rotateY(PI/3);
  //texture(textureImg);
  noStroke();
  fill(0,255,0);
  drawCylinder( 30, 100, 300 );
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
        terrain[i][j] = map(noise(xoff,yoff), 0, 1, -15, 15); // on convertit la valeur de noise qui vaut entre 0 et 1 en une valeur entre -100 et 100
        xoff += 0.1f;
    }
    yoff += 0.2f;
    }
    // draw sides
    //textureMap = new float[sides+1][2];

    beginShape(TRIANGLE_STRIP);
    //texture(textureImg);
    for(int j = 0; j < sides; j++){
      for (int i = 0; i < sides + 1; i++) {
          float x = cos( radians( i * angle ) ) * r;
          float y = sin( radians( i * angle ) ) * r;
          //textureMap[i][0] = sin( radians( i * angle ) ) * (textureImg.width/2) + (textureImg.width/2) ;
          //textureMap[i][1] = cos( radians( i * angle ) ) * (textureImg.height/2) + (textureImg.height/2) ;
          //float y = sin( radians( i * angle ) ) * r;

          texture(textureImg);
          vertex( x + terrain[i][j], y + terrain[i][j], -h/2 + (j*h)/sides, map(i,0,sides,0,textureImg.width), map(j,0,sides,0,textureImg.height));
          vertex( x + terrain[i][j+1], y + terrain[i][j+1], -h/2 + ((j+1)*h)/sides, map(i,0,sides,0,textureImg.width), map(j+1,0,sides,0,textureImg.height));
      }
    }
      endShape();
}
  public void settings() {  size(600, 600, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "cylindreTexture" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
