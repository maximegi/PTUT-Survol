import peasy.*;

PeasyCam cam;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

float distanceX = 0.0;
float distanceY = 0.0;
boolean NORTH, SOUTH, WEST, EAST;
float[][] terrain;

void setup()
{
  size(1080, 720, P3D);
  cam = new PeasyCam(this, 200);
  cols = w / scl;
  rows = h / scl;
  terrain = new float[cols][rows];
}

void draw()
{
  perlinMoving();
  //placement camera maxime
  rotateX(PI/2);
  rotateZ(-PI/2);
  translate(-50,-cols/2,-110);
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
  // stroke(255);
  //test ellipse
  // fill(175);
  // ellipse(orientation.x,orientation.y,50,50);

  noStroke();
  fill(0,155,0);
  directionalLight(102, 202, 186, 1, 1, 0);
  ambientLight(30, 30, 30);

  float angle = 180.0 / cols;
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
        vertex(x, yp, zp);
        vertex(x, yf, zf);
    }
    endShape();
  }
}

float[][] perlinMoving()
{
  float pasPerlin = 0.01;
  float vitesseVol = 0.01;
  int sizeNoise = 20;

  PVector orientation = new PVector(0.0, 0.0);
  //generate perlin noise
  orientation.x = distanceX;
  for (int x = 0; x < cols; x++)
  {
    orientation.y = distanceY;
    for (int y = 0; y < rows; y++)
    {
      terrain[x][y] = map(noise(orientation.x, orientation.y), 0, 1, -sizeNoise, sizeNoise);
      orientation.y += pasPerlin;
    }
    orientation.x += pasPerlin;
  }

  //translate the mesh
  if (NORTH)  distanceX-=vitesseVol;
  if (SOUTH)  distanceX+=vitesseVol;
  if (WEST)   distanceY-=vitesseVol;
  if (EAST)   distanceY+=vitesseVol;

  return terrain;
}

void keyPressed()
{
  final int k = keyCode;
  if (k == UP)   NORTH = true;
  else if (k == DOWN)   SOUTH = true;
  else if (k == LEFT)   WEST  = true;
  else if (k == RIGHT)   EAST  = true;
}

void keyReleased()
{
  final int k = keyCode;
  //↓↓↓ uncomment to manually move the mesh ↓↓↓ if comment to push UP and DOWN another time
  //if      (k == UP)   NORTH = false;
  //else if (k == DOWN)   SOUTH = false;
  if (k == LEFT)   WEST  = false;
  else if (k == RIGHT)   EAST  = false;
}
