import peasy.*;

PeasyCam cam;

int cols, rows;
int scl = 20;
int w = 2000;
int h = 1600;

float flying = 0;

float[][] terrain;

void setup() {
  size(1920, 1080, P3D);
  cam = new PeasyCam(this, 500);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}

void draw() {
  //up arrow fly
  if (keyCode == UP)
  {
    flying-=0.01;
  }
  //down arrow reverse fly
  else if (keyCode == DOWN)
  {
    flying+=0.01;
  }
  float yoff = flying;
  for (int y = 0; y < rows; y++) {
    float xoff = 0;
    for (int x = 0; x < cols; x++) {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -5, 5);
      xoff += 0.03;
    }
    yoff += 0.03;
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

  float angle = 180.0 / cols;
  int r = 50;
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
        // float zp = 0;
        // //z future
        // float zf = 0;

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
        vertex( x*scl, yp*scl, zp*scl);
        vertex( x*scl,  yf*scl, zf*scl);
    }
    endShape();
  }
}
