import peasy.*;

//PeasyCam cam;

PGraphics pgPlanarView, pgMappedView;

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
}

void draw() {
  //up arrow fly
  if (keyCode == LEFT)
  {
    flying-=0.03;
  }
  //down arrow reverse fly
  else if (keyCode == RIGHT)
  {
    flying+=0.03;
  }



  float xoff = flying;
  for (int x = 0; x < cols; x++)
  {
    float yoff = 0;
    for (int y = 0; y < rows; y++)
    {
      terrain[x][y] = map(noise(xoff, yoff), 0, 1, -20, 20);

      //Deuxième bruit de perlin permettant de faire des variations de texturing sur le sol
      float m = 1 * noise(3 * xoff, 3 * yoff) +  0.5 * noise(2 * xoff, 2 * yoff) + 0.25 * noise(4 * xoff, 4 * yoff);
      terrainTexture[x][y] = pow(m, 1.42);
      yoff += 0.01;
    }
    xoff += 0.01;
  }

  drawPlanar(pgPlanarView, cols, rows, terrain);
  mapCylinder(pgMappedView, cols, rows, 100, terrain);

  image(pgPlanarView, 0,0);
  image(pgMappedView, width/2,0);
}
