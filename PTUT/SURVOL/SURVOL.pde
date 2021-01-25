void setup()
{
  size(1080, 720, P3D);
  initValues();
  cols = w / scl;
  rows = h / scl;
  img = loadImage("assets/sea.jpg");

  background(100,100,100);
  texturedTerrain.initRefinedTerrain(waterThreshold, sandThreshold, clayThreshold, grassThreshold, 1);
  customCamera.initCam(cameraWidth, cameraHeight, eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  texturedTerrain.addTreeToList("assets/lowpolytree.obj");
}

float perlin(float posX, float posY)
{
  float noise = 1 * noise(1 * posX, 1 * posY) +  0.5 * noise(2 * posX, 2 * posY) + 0.25 * noise(4 * posX, 4 * posY);
  return map(noise, 0, 1.75, -1, 1);
}

float perlinTexture(float posX, float posY)
{
  float m = 1 * noise(3 * posX, 3 * posY) +  0.5 * noise(2 * posX, 2 * posY) + 0.25 * noise(4 * posX, 4 * posY);
  m = pow(m, 1.42);
  //return map(m, 0, pow(1.75, 1.42), 0, 1);
  return m;
}

float perlinTrees(float posX, float posY)
{
  float nX = posX/cols -0.5;
  float nY = posY/rows -0.5;

  return map(noise(15*posX, 15*posY),0,1, 0, 200);
}

void draw()
{
  texturedTerrain.update();
  customCamera.useCam();
  customCamera.update();
  mesh.move();
   //drawAxes();


  //drawPlanar(cols, rows, sizeNoise, pasPerlin, mesh, texturedTerrain);
  mapCylinder(cols, rows, 100, sizeNoise, pasPerlin, mesh, texturedTerrain);

}
