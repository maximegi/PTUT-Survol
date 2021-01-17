import peasy.*;

//PeasyCam cam;

PGraphics pgPlanarView, pgMappedView;
PImage img1, img2;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

float flying = 0;

float[][] terrain;
float[][] terrainTexture;

Camera camera = new Camera();

void setup() {
  size(1920, 1080, P3D);
  //cam = new PeasyCam(this, 500);
  cols = w / scl;
  rows = h/ scl;
  terrain = new float[cols][rows];
  terrainTexture = new float[cols][rows];

  pgPlanarView = createGraphics(width/2,height, P3D);
  pgMappedView = createGraphics(width/2,height, P3D);

  img1 = loadImage("ground.jpg");
  img2 = loadImage("snow.jpg");


}

void draw() {
  //up arrow fly
  if (keyCode == LEFT)
  {
    flying-=0.01;
  }
  //down arrow reverse fly
  else if (keyCode == RIGHT)
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
      float m = 1 * noise(1 * xoff, 1 * yoff) +  0.5 * noise(2 * xoff, 2 * yoff) + 0.25 * noise(4 * xoff, 4 * yoff);
      terrainTexture[x][y] = pow(m, 1.42);
      yoff += 0.01;
    }
    xoff += 0.01;
  }

/*
  for(int j = 0; j < rows-1; j++){
    for (int i = 0; i < cols; i++){
      textures[i][j] = createImg(img1, img2, 0.5);
    }
  }*/

  drawPlanar(pgPlanarView, cols, rows, terrain);
  mapCylinder(pgMappedView, cols, rows, 100, terrain);

  image(pgPlanarView, 0,0);
  image(pgMappedView, width/2,0);
}
