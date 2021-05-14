void setup(){
  size(1920, 1070, P3D);
  // fullScreen();
  // Sky initialization and generation
  sky = createGraphics(width,height);

  MidiBus.list();
  myBus = new MidiBus(this, 0,1);

  createSky();

  initValues();
  cols = w / scl;
  rows = h / scl;

  // Initialization of our terrain and camera
  texturedTerrain.initRefinedTerrain(waterThreshold, sandThreshold, clayThreshold, grassThreshold, 1);
  customCamera.initCam(cameraWidth, cameraHeight, eyeX, eyeY, paramEyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  // Loading of scene's assets (trees, rocks, etc)
  texturedTerrain.addTreeToList("assets/empty.obj");
  texturedTerrain.addTreeToList("assets/tree_1.obj");
  texturedTerrain.addTreeToList("assets/tree_2.obj");
  texturedTerrain.addTreeToList("assets/tree_3.obj");
  texturedTerrain.addTreeToList("assets/tree_4.obj");
  texturedTerrain.addTreeToList("assets/tree_5.obj");
  texturedTerrain.addTreeToList("assets/rock.obj");
}

float perlin(float posX, float posY){
  float noise = 1 * noise(1 * posX, 1 * posY) +  0.5 * noise(2 * posX, 2 * posY) + 0.25 * noise(4 * posX, 4 * posY);
  return map(noise, 0, 1.75, -1, 1);
}

float perlinTexture(float posX, float posY){
  float m = 1 * noise(3 * posX, 3 * posY) +  0.5 * noise(2 * posX, 2 * posY) + 0.25 * noise(4 * posX, 4 * posY);
  m = pow(m, 1.42);
  return m;
}

float perlinTrees(float posX, float posY){
  float nX = posX/cols -0.5;
  float nY = posY/rows -0.5;
  return map(noise(15*posX, 15*posY),0,1, 0, 200);
}

void draw(){
  showBackground();
  //changeBackground();

  // Scene Illumination
  ambientLight(217, 202, 196);
  directionalLight(20, 20, 40, 0, 90, 0);
  pointLight(150, 150, 150, 700, 500, 900);
  pointLight(150, 150, 150, 400, 500, 900);

  // Update functions
  texturedTerrain.update();
  customCamera.useCam();
  customCamera.update();
  mesh.move();

  //drawAxes();
   translate(-115,100,200);

  mapCylinder(cols, rows, 120, sizeNoise, pasPerlin, mesh, texturedTerrain);
}
