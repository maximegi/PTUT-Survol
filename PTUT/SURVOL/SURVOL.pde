void setup()
{
  size(1080, 720, P3D);
  //cam = new PeasyCam(this, 200);
  cols = w / scl;
  rows = h / scl;
  terrainTexture = new float[cols][rows];
}

float perlin(float posX, float posY)
{
  return map(noise(posX, posY), 0, 1, -1, 1);
}

void draw()
{
  mesh.move();

  float xoff = 0;
  for (int x = 0; x < cols; x++){
    float yoff = 0;
    for (int y = 0; y < rows; y++)
    {
      //Deuxième bruit de perlin permettant de faire des variations de texturing sur le sol
      float m = 1 * noise(3 * xoff, 3 * yoff) +  0.5 * noise(2 * xoff, 2 * yoff) + 0.25 * noise(4 * xoff, 4 * yoff);
      terrainTexture[x][y] = pow(m, 1.42);
      yoff += pasPerlin;
    }
    xoff += pasPerlin;
  }

  //drawPlanar(cols, rows, sizeNoise, pasPerlin, mesh);
  mapCylinder(cols, rows, 100, sizeNoise, pasPerlin, mesh);

}
