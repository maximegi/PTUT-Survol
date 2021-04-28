class Terrain
{
  //parameters
  PVector position = new PVector(0., 0.);
  PVector direction = new PVector(.001, 0.);
  int w;
  int h;
  float deltaPos = 1;
  float deltaAngle = 1;

  float x(){return position.x;}
  float y(){return position.y;}
  int w(){return w;}
  int h(){return h;}

  Terrain(float x, float y, int w, int h)
  {
    this.position.x = x;
    this.position.y = y;
    this.w = w;
    this.h = h;
  }

  void move()
  {

    if (NORTH) position.x+=deltaPos;
    if (SOUTH) position.x-=deltaPos;
    if (WEST && !SHIFTPRESSED) position.y-=deltaPos;
    if (EAST && !SHIFTPRESSED) position.y+=deltaPos;
    if (WEST && SHIFTPRESSED) rotate2D(direction, -deltaAngle);
    if (EAST && SHIFTPRESSED) rotate2D(direction, deltaAngle);
    pushMatrix();
      translate(direction.x, direction.y);
      rotate(atan2(direction.y, direction.x));
      rect(this.position.x, this.position.y, this.w, this.h);
    popMatrix();
  }

}

boolean NORTH, SOUTH, WEST, EAST, SHIFTPRESSED;

void keyPressed()
{
  final int k = keyCode;
  if (k == UP) NORTH = true;
  else if (k == DOWN) SOUTH = true;
  else if (k == LEFT) WEST  = true;
  else if (k == RIGHT) EAST  = true;
  else if (k == SHIFT) SHIFTPRESSED = true;
}

void keyReleased()
{
  final int k = keyCode;
  //↓↓↓ uncomment to manually move the mesh ↓↓↓ if comment to push UP and DOWN another time
  if      (k == UP) NORTH = false;
  else if (k == DOWN) SOUTH = false;
  else if (k == LEFT) WEST  = false;
  else if (k == RIGHT) EAST  = false;
  else if (k == SHIFT) SHIFTPRESSED = false;
}

void rotate2D(PVector v, float theta)
{
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}
