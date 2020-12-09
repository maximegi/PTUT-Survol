import peasy.*;

PeasyCam cam;

float[][] terrain;

void setup()
{
    size(600, 600, P3D);
    cam = new PeasyCam(this, 200);
    lights();
    fill(100, 200, 0);
}

void draw()
{
  background(255);
  pushMatrix();
  translate(width/2,height/2);
  rotateY(PI/3);
  drawCylinder( 30, 100, 300 );
  popMatrix();
}

void drawCylinder( int sides, float r, float h)
{
    float angle = 360 / sides;
    float yoff = 0;

    terrain = new float[sides+1][sides+1];
    for ( int j=0; j < sides; j++){
      float xoff = 0;
      for (int i=0; i < sides; i++){
        terrain[i][j] = map(noise(xoff,yoff), 0, 1, -15, 15); // on convertit la valeur de noise qui vaut entre 0 et 1 en une valeur entre -100 et 100
        xoff += 0.1;
    }
    yoff += 0.2;
    }
    // draw sides
    beginShape(TRIANGLE_STRIP);
    for(int j = 0; j < sides; j++){
      for (int i = 0; i < sides + 1; i++) {
          float x = cos( radians( i * angle ) ) * r;
          float y = sin( radians( i * angle ) ) * r;
          vertex( x + terrain[i][j], y + terrain[i][j], -h/2 + (j*h)/sides);
          vertex( x + terrain[i][j+1], y + terrain[i][j+1], -h/2 + ((j+1)*h)/sides);
      }
    }
      endShape();
}
