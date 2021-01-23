import peasy.*;

PeasyCam cam;
Camera camera = new Camera();

int cols, rows;
int scl = 40;
int w = 5000;
int h = 5000;

float pasPerlin = 0.01;
int sizeNoise = 40;

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
float[][] terrainTexture;
