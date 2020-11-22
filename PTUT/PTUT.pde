int cols, rows;
int scl = 20;
int w = 2000;
int h = 1900;

float[][] terrain;
float flying = 0.0;

void setup() {
  size(600, 600, P3D);
  cols = w/scl;
  rows = h/scl;
  terrain = new float[cols][rows];
}

void draw(){
  flying -= 0.08;

  float yoff = flying;
   for ( int y=0; y < rows; y++){
     float xoff = 0;
     for (int x=0; x <cols; x++){
       terrain[x][y] = map(noise(xoff,yoff), 0, 1, -50, 50); // on convertit la valeur de noise qui vaut entre 0 et 1 en une valeur entre -100 et 100
       xoff += 0.1;
     }
     yoff += 0.2;
   }

 background(0);
 noStroke();
 fill(0,180,0);
 directionalLight(126, 126, 126, 0, 0, -2);
 ambientLight(90, 90, 90);

 translate(width/2, height/2+20);
 rotateX((1.2*PI)/3);
 translate(-w/2, -h/2);

 for ( int y=0; y < rows-1; y++){
   beginShape(TRIANGLE_STRIP);
   for (int x=0; x <cols; x++){
     vertex(x*scl, y*scl, terrain[x][y]);
     vertex(x*scl, (y+1)*scl, terrain[x][y+1]);
   }
   endShape();
 }
}
