import peasy.*;

//PeasyCam cam;

PGraphics pgPlanarView, pgMappedView;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

int R = 0;

PShape tree;
float offsetTree = 4;

Terrain mesh = new Terrain(-(w / (2*scl)), -(h / (2*scl)), w / scl, h / scl);

float[][] terrainTexture;
float[][] treeNoise;

Camera camera = new Camera();

void setup() {

  size(1920, 1080, P3D);
  //cam = new PeasyCam(this, 500);
  cols = w / scl;
  rows = h/ scl;

  tree = loadShape("lowpolytree.obj");

  terrainTexture = new float[cols][rows];
  treeNoise = new float[cols][rows];

  pgPlanarView = createGraphics(width/2,height, P3D);
  pgMappedView = createGraphics(width/2,height, P3D);

}

float perlin(float posX, int j, float posY, int i, int sizeNoise, float pasPerlin){
  return map(noise(posX + j * pasPerlin, posY + i * pasPerlin), 0, 1, -sizeNoise, sizeNoise);
}

void draw() {
  float pasPerlin = 0.01;
  int sizeNoise = 20;
  mesh.move();


  float xoff = 0;
  for (int x = 0; x < cols; x++){
    float yoff = 0;
    for (int y = 0; y < rows; y++)
    {
      //Deuxième bruit de perlin permettant de faire des variations de texturing sur le sol
      float m = 1 * noise(3 * xoff, 3 * yoff) +  0.5 * noise(2 * xoff, 2 * yoff) + 0.25 * noise(4 * xoff, 4 * yoff);
      terrainTexture[x][y] = pow(m, 1.42);

      float nx = xoff/cols - 0.5;
      float ny = yoff/rows - 0.5;
      treeNoise[x][y] = noise(50 * nx, 50 * ny);

      yoff += pasPerlin;
    }
    xoff += pasPerlin;
  }

  //drawPlanar(pgPlanarView, cols, rows, sizeNoise, pasPerlin, mesh);
  mapCylinder(pgMappedView, cols, rows, 100, sizeNoise, pasPerlin, mesh);

  image(pgPlanarView, 0,0);
  image(pgMappedView, width/2,0);
}
