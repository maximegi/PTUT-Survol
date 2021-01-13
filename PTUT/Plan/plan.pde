import peasy.*;

PeasyCam cam;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;
float width = 800;
float height = 800;
float flying = 0;

float[][] terrain;

Camera camera = new Camera();

void setup() {
  size(800, 800, P3D);
  //cam = new PeasyCam(this, 500);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
}

void draw() {
  camera(camera.eyeX,camera.eyeY,camera.eyeZ,camera.centerX,camera.centerY,camera.centerZ,camera.upX,camera.upY,camera.upZ);
  camera.update();
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
  float xoff = flying;
  for (int x = 0; x < cols; x++)
  {
    float yoff = 0;
    for (int y = 0; y < rows; y++)
    {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -20, 20);
      yoff += 0.01;
    }
    xoff += 0.01;
  }
  //translate(width/2,height/2);
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


  float angle = 180.0 / cols;
  int r = 100;
  translate(-rows/2,0);
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
        /*vertex( x, yp, zp);
        vertex( x,  yf, zf);*/
        vertex( yp, -zp, x);
        vertex( yf,  -zf, x);
    }
    endShape();
  }
}