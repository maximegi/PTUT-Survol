Camera customCamera = new Camera();
RefinedTerrain texturedTerrain = new RefinedTerrain();



int cols, rows;
int scl = 40;
int w = 5000;
int h = 5000;

float pasPerlin = 0.01;
int sizeNoise = 40;

float waterThreshold = 0.0;
float sandThreshold = 0.0;
float clayThreshold = 0.0;
float grassThreshold = 0.0;
int treeDensity = 0;

MovingArea mesh = new MovingArea(-(w / (2*scl)), -(h / (2*scl)), w / scl, h / scl);

//Camera parameters (to be initialized)
float cameraWidth = 800;
float cameraHeight = 800;
float eyeX = 0;//cameraWidth/2;
float eyeY = 0;//cameraHeight/2;
float eyeZ = 0.4*(cameraHeight/2)/tan(PI/6);
float centerX = 0;//cameraWidth/2;
float centerY = 0;//cameraHeight/2;
float centerZ = 0.0;
float upX = 0;
float upY = 1;
float upZ = 0;

//Texturing

color grass = color(63,101,29);
color grassTmp = color(0,0,0);

color clay = color(158,127,79);
color clayTmp = color(0,0,0);

color sand = color(229,217,194);
color sandTmp = color(0,0,0);
/*
color water = color(45,127,150);
color waterTmp = color(0,0,0);
*/
//color water = color(1,169,193);
color water = color(1,50,57);
color waterTmp = color(0,0,0);

PImage img;
boolean normal = false;