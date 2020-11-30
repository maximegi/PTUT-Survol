import peasy.*;

PeasyCam cam;

PVector[][] globe;
int detail = 85;
int cols, rows;
int scl = 20;
int w = 2000;
int h = 1900;

float[][] terrain;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 500);
  globe = new PVector[detail+1][detail+1];
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
}

void draw() {
  background(0);
  noStroke();
  lights();
  //translate(width/2,height/2);
  float r = 200;
  float yoff = 0;
  //rotateY(90);

  for (int i = 0; i < detail+1; i++) {
    float lat = map(i, 0, detail, 0, PI);
    float xoff = 0;
    for (int j = 0; j < detail+1; j++) {
      float lon = map(j, 0, detail, 0, TWO_PI);
      float x = r * sin(lat) * cos(lon);
      float y = r * sin(lat) * sin(lon);
      float z = r * cos(lat);
      globe[i][j] = new PVector(x, y, z);
      terrain[i][j] = map(noise(xoff,yoff), 0, 1, -50, 50); // on convertit la valeur de noise qui vaut entre 0 et 1 en une valeur entre -100 et 100

      /*float coeff1 = 1.0;
      if(globe[i][j].x <0.0){
        coeff1 = - coeff1;
      }
      float coeff2 = 1.0;
      if(globe[i][j].y <0.0){
        coeff2 = - coeff2;
      }
      float coeff3 = 1.0;
      if(globe[i][j].z <0.0){
        coeff3 = - coeff3;
      }
      globe[i][j].x = globe[i][j].x + coeff1*terrain[i][j];
      globe[i][j].y = globe[i][j].y + coeff2*terrain[i][j];
      globe[i][j].z = globe[i][j].z + coeff3*terrain[i][j];*/
      xoff += 0.1;
    }
    yoff += 0.2;
  }

  for (int i = 0; i < detail; i++) {
    beginShape(TRIANGLE_STRIP);
    for (int j = 0; j < detail+1; j++) {
      PVector v1 = globe[i][j];
      vertex(v1.x+terrain[i][j], v1.y+terrain[i][j], v1.z+terrain[i][j]);
      PVector v2 = globe[i+1][j];
      vertex(v2.x+terrain[i+1][j], v2.y+terrain[i+1][j], v2.z+terrain[i+1][j]);
    }
    endShape();
  }
}
