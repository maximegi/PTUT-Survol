class MovingArea
{
  //parameters
  int w;
  int h;

  float deltaPos = .01;
  float deltaAngle = .01;

  PVector position = new PVector(0., 0.);
  PVector direction = new PVector(1., 0.);
  PVector orthodirection = new PVector(0., 1.);
  PVector translation = new PVector(0., 0.);

  PVector getPosition(){return position;}

  float getX(){return position.x;}
  float getY(){return position.y;}
  float getDirX(){return direction.x;}
  float getDirY(){return direction.y;}
  float getOrthoX(){return orthodirection.x;}
  float getOrthoY(){return orthodirection.y;}

  MovingArea(float x, float y, int w, int h)
  {
    this.position.x = x;
    this.position.y = y;
    this.w = w;
    this.h = h;
  }

  void moveForward()
  {
    position.x += deltaPos * direction.x;
    position.y += deltaPos * direction.y;
  }

  void moveBackward()
  {
    position.x -= deltaPos * direction.x;
    position.y -= deltaPos * direction.y;
  }

  void rotatemArea(float theta)
  {
    float xTemp1 = direction.x;
    float xTemp2 = orthodirection.x;
    direction.x = direction.x*cos(theta) - direction.y*sin(theta);
    direction.y = xTemp1*sin(theta) + direction.y*cos(theta);
    orthodirection.x = orthodirection.x*cos(theta) - orthodirection.y*sin(theta);
    orthodirection.y = xTemp2*sin(theta) + orthodirection.y*cos(theta);
  }

  void move()
  {
    if (NORTH) this.moveForward();
    if (SOUTH) this.moveBackward();
    if (WEST && !SHIFTPRESSED) this.rotatemArea(-deltaAngle);
    if (EAST && !SHIFTPRESSED) this.rotatemArea(deltaAngle);
    if (WEST && SHIFTPRESSED) this.rotatemArea(-deltaAngle);
    if (EAST && SHIFTPRESSED) this.rotatemArea(deltaAngle);
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
  //↓↓↓ uncomment to manually move the mesh ↓↓↓ if comment dont push UP and DOWN another time
  if      (k == UP) NORTH = false;
  else if (k == DOWN) SOUTH = false;
  else if (k == LEFT) WEST  = false;
  else if (k == RIGHT) EAST  = false;
  else if (k == SHIFT) SHIFTPRESSED = false;
}
