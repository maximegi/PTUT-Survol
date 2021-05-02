void setup()
{
  size(1920, 1080, P3D);
  sky = createGraphics(width,height);
  //background(100,100,100);
  createBg();

  initValues();
  //cam = new PeasyCam(this, 200);
  cols = w / scl;
  rows = h / scl;
  //img = loadImage("assets/sea.jpg");


  texturedTerrain.initRefinedTerrain(waterThreshold, sandThreshold, clayThreshold, grassThreshold, 1);
  customCamera.initCam(cameraWidth, cameraHeight, eyeX, eyeY, paramEyeZ, centerX, centerY, centerZ, upX, upY, upZ);

  //texturedTerrain.addTreeToList("assets/lowpolytree.obj");
  //texturedTerrain.addTreeToList("assets/leaflessTree.obj");
  //texturedTerrain.addTreeToList("assets/snowTree.obj");
  //texturedTerrain.addTreeToList("assets/regularTree.obj");
  //texturedTerrain.addTreeToList("assets/regularTree2.obj");
  //texturedTerrain.addTreeToList("assets/leaflessTreeSnow.obj");
  texturedTerrain.addTreeToList("assets/empty.obj");
  texturedTerrain.addTreeToList("assets/tree_1.obj");
  texturedTerrain.addTreeToList("assets/tree_2.obj");
  texturedTerrain.addTreeToList("assets/tree_3.obj");
  texturedTerrain.addTreeToList("assets/tree_4.obj");
  texturedTerrain.addTreeToList("assets/tree_5.obj");
  texturedTerrain.addTreeToList("assets/rock.obj");

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
  backgroundType();
  changeBackground();
  //createBg();
  //pointLight(255, 255, 255, 700, 500, 900);
  ambientLight(217, 202, 196);
  directionalLight(20, 20, 40, 0, 90, 0);

  pointLight(150, 150, 150, 700, 500, 900);
  pointLight(150, 150, 150, 400, 500, 900);
  texturedTerrain.update();
  customCamera.useCam();
  customCamera.update();
  mesh.move();
   //drawAxes();
   translate(-115,100,200);
  //drawPlanar(cols, rows, sizeNoise, pasPerlin, mesh, texturedTerrain);
  mapCylinder(cols, rows, 120, sizeNoise, pasPerlin, mesh, texturedTerrain);
  //directionalLight(255, 0, 0, 100, 0, 0);

}

void createBg(){
  sky.beginDraw();
  sky.noStroke();
  sky.rect(0,0, width,3*height/4);

  for (float i = 0; i < 3*height/4; i += step) {
    for (float j = 0; j < width; j += step) {
      float n = noise(j/200., i/50.);
      //sky.fill(9, 177, 236, n*map(i, 0, 3*height/4, 255, 0));
      sky.fill(58, 163, 190, n*map(i, 0, 3*height/4, 255, 220));
      sky.rect(j,i, step,step);
    }
  }
  sky.endDraw();
}

void backgroundType(){
  if(bgSelect == 0){
    background(sky);
  }
  else if(bgSelect == 1){
    background(255);
  }
  else{
    background(0);
  }
}

void changeBackground(){
  if(keyPressed){
    if(key == '²'){
      if(bgSelect == 2){
        bgSelect = 0;
      }
      else{
        bgSelect ++;
      }
    }
  }
  keyPressed = false;
}
