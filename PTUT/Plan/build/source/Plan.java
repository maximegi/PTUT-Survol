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

Terrain mesh = new Terrain(-(w / (2*scl)), -(h / (2*scl)), w / scl, h / scl);

public void setup()
{
  
  cam = new PeasyCam(this, 200);
  cols = w / scl;
  rows = h / scl;
}

public float perlin(float posX, int j, float posY, int i, int sizeNoise, float pasPerlin)
{
  return map(noise(posX + j * pasPerlin, posY + i * pasPerlin), 0, 1, -sizeNoise, sizeNoise);
}

public void draw()
{
  float pasPerlin = 0.01f;
  int sizeNoise = 20;
  //peasycam maxime
  rotateX(PI/2);
  rotateZ(-PI/2);
  translate(-50,-cols/2,-110);
  ////////////////////////////

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

  //display mesh's footprint on perlin
  // pushMatrix();
  mesh.move();
  rect(mesh.x(), mesh.y(), mesh.w(), mesh.h());
  // popMatrix();


  noStroke();
  fill(0,155,0);
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
        // float zp = perlin(mesh.x(), i, mesh.y(), j, sizeNoise, pasPerlin);
        // //z future
        // float zf = perlin(mesh.x(), i, mesh.y(), j+1, sizeNoise, pasPerlin);

        //convert coordinate to cylinderspace
        float x = cos( radians( i * angle ) ) * r;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = sin( radians( i * angle ) ) * r + perlin(mesh.x(), i, mesh.y(), j, sizeNoise, pasPerlin);
        //z future
        float zf = sin( radians( i * angle ) ) * r + perlin(mesh.x(), i, mesh.y(), j+1, sizeNoise, pasPerlin);

        //triangle vertices
        vertex(x-rows/2, yp-cols/2, zp);
        vertex(x-rows/2, yf-cols/2, zf);
    }
    endShape();
  }
}

// //dont use this
// float[][] perlinTab(Terrain terrain, int sizeNoise, int scl, float pasPerlin)
// {
//   int cols = w / scl;
//   int rows = h / scl;
//   float[][] perlinTab = new float[cols][rows];
//   float posX = terrain.x();
//   float posY = terrain.y();
//   for (int x = 0; x < cols; x++)
//   {
//     for (int y = 0; y < rows; y++)
//     {
//       perlinTab[x][y] = map(noise(posX, posY), 0, 1, -sizeNoise, sizeNoise);
//       posY += pasPerlin;
//     }
//     posX += pasPerlin;
//   }
//   return perlinTab;
// }
class Terrain
{
  //parameters
  PVector position = new PVector(0.f, 0.f);
  PVector direction = new PVector(.001f, 0.f);
  int w;
  int h;
  float deltaPos = .01f;
  float deltaAngle = .01f;

  public float x(){return position.x;}
  public float y(){return position.y;}
  public int w(){return w;}
  public int h(){return h;}

  Terrain(float x, float y, int w, int h)
  {
    this.position.x = x;
    this.position.y = y;
    this.w = w;
    this.h = h;
  }

  public void move()
  {

    if (NORTH) position.x+=deltaPos;
    if (SOUTH) position.x-=deltaPos;
    if (WEST && !SHIFTPRESSED) position.y-=deltaPos;
    if (EAST && !SHIFTPRESSED) position.y+=deltaPos;
    if (WEST && SHIFTPRESSED) rotate2D(direction, -deltaAngle);
    if (EAST && SHIFTPRESSED) rotate2D(direction, deltaAngle);
    translate(direction.x, direction.y);
    rotate(atan2(direction.y, direction.x));
  }

}

boolean NORTH, SOUTH, WEST, EAST, SHIFTPRESSED;

public void keyPressed()
{
  final int k = keyCode;
  if (k == UP) NORTH = true;
  else if (k == DOWN) SOUTH = true;
  else if (k == LEFT) WEST  = true;
  else if (k == RIGHT) EAST  = true;
  else if (k == SHIFT) SHIFTPRESSED = true;
}

public void keyReleased()
{
  final int k = keyCode;
  //↓↓↓ uncomment to manually move the mesh ↓↓↓ if comment to push UP and DOWN another time
  if      (k == UP) NORTH = false;
  else if (k == DOWN) SOUTH = false;
  else if (k == LEFT) WEST  = false;
  else if (k == RIGHT) EAST  = false;
  else if (k == SHIFT) SHIFTPRESSED = false;
}

public void rotate2D(PVector v, float theta)
{
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}
  public void settings() {  size(1080, 720, P3D); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Plan" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
