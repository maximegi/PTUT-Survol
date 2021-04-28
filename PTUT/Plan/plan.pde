import peasy.*;

PeasyCam cam;

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

Terrain mesh = new Terrain(-(w / (2*scl)), -(h / (2*scl)), w / scl, h / scl);

void setup()
{
  size(1080, 720, P3D);
  cam = new PeasyCam(this, 200);
  cols = w / scl;
  rows = h / scl;
}

float perlin(float posX, int j, float posY, int i, int sizeNoise, float pasPerlin)
{
  return map(noise(posX + j * pasPerlin, posY + i * pasPerlin), 0, 1, -sizeNoise, sizeNoise);
}

void draw()
{
  float pasPerlin = 0.01;
  int sizeNoise = 20;
  //peasycam maxime
  // rotateX(PI/2);
  // rotateZ(-PI/2);
  // translate(-50,-cols/2,-110);
  ////////////////////////////

  background(100);
  //x axis
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  stroke(0, 0, 255);
  line(0, -1000, 0, 0, 1000, 0);
  //z axis
  stroke(0, 255, 0);
  line(0, 0, -1000, 0, 0, 1000);
  stroke(255);
  noFill();

  //display mesh's footprint on perlin
  // pushMatrix();
  mesh.move();
  // popMatrix();


  noStroke();
  fill(0,155,0);
  directionalLight(102, 202, 186, 1, 1, 0);
  ambientLight(30, 30, 30);

  float angle = 180.0 / cols;
  int r = 100;
  //translate(-rows/2,0);
  for(int j = 0; j < rows-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //cartesian coordinates
        float x = i;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = perlin(mesh.x(), i, mesh.y(), j, sizeNoise, pasPerlin);
        //z future
        float zf = perlin(mesh.x(), i, mesh.y(), j+1, sizeNoise, pasPerlin);

        // //convert coordinate to cylinderspace
        // float x = cos( radians( i * angle ) ) * r;
        // //y past
        // float yp = j;
        // //y future
        // float yf = j+1;
        // //z past
        // float zp = sin( radians( i * angle ) ) * r + perlin(mesh.x(), i, mesh.y(), j, sizeNoise, pasPerlin);
        // //z future
        // float zf = sin( radians( i * angle ) ) * r + perlin(mesh.x(), i, mesh.y(), j+1, sizeNoise, pasPerlin);

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
