/*import peasy.*;

PeasyCam cam;*/
Camera camera = new Camera();

int cols, rows;
int scl = 20;
int w = 5000;
int h = 5000;

float pasPerlin = 0.01;
int sizeNoise = 40;

Terrain mesh = new Terrain(-(w / (2*scl)), -(h / (2*scl)), w / scl, h / scl);
RefinedTerrain texturedTerrain = new RefinedTerrain(-0.2, 0.05, 0.05, 2);

//Camera parameters (to be initialized)
float cameraWidth = 800;
float cameraHeight = 800;
float eyeX = 0;//cameraWidth/2;
float eyeY = 0;//cameraHeight/2;
float eyeZ = (cameraHeight/2)/tan(PI/6);
float centerX = 0;//cameraWidth/2;
float centerY = 0;//cameraHeight/2;
float centerZ = 0.0;
float upX = 0;
float upY = 1;
float upZ = 0;

//Texturing
float[][] terrainTexture;

color grass = color(63,101,29);
color grassTmp = color(0,0,0);

color clay = color(158,127,79);
color clayTmp = color(0,0,0);

color sand = color(229,217,194);
color sandTmp = color(0,0,0);

color water = color(45,127,150);;
color waterTmp = color(0,0,0);
