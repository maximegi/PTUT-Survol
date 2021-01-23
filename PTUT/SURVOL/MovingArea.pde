class MovingArea
{
  //parameters
  int w;
  int h;

  float deltaPos = .01;
  float deltaAngle = .0008;

  PVector position = new PVector(0., 0.);
  PVector direction = new PVector(1., 0.);
  PVector orthodirection = new PVector(0., 1.);
  PVector translation = new PVector(0., 0.);

  PVector getPosition(){return position;}

  float getX(){return position.x;}
  float getY(){return position.y;}

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

  void rotatemArea(float angle)
  {
    direction.x = direction.x * cos(angle) + direction.y * sin(angle);
    direction.y = -direction.x * sin(angle) + direction.y * cos(angle);
  }

  void move()
  {
    if (NORTH) this.moveForward();
    if (SOUTH) this.moveForward();
    if (WEST && !SHIFTPRESSED) this.rotatemArea(-deltaAngle);
    if (EAST && !SHIFTPRESSED) this.rotatemArea(deltaAngle);
    // if (WEST && SHIFTPRESSED) {rotate2D(direction, -deltaAngle); rotate2D(orthodirection, -deltaAngle);}
    // if (EAST && SHIFTPRESSED) {rotate2D(direction, deltaAngle); rotate2D(orthodirection, deltaAngle);}
    // pushMatrix();
    //   translate(translation.x, translation.y);
    //   rotate(atan2(direction.y, direction.x));
    //   // rect(-w/2, -h/2, w, h);
    //   //bottom left
    //   float x = modelX(-w/2, -h/2, 0);
    //   float y = modelY(-w/2, -h/2, 0);
    // popMatrix();
    // //bottom left point
    // p.x = x;
    // p.y = y;
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
  if (key == 'p' || key == 'P'){
    exportValues();
  }
}

void keyReleased()
{
  /*
  final int k = keyCode;
  //↓↓↓ uncomment to manually move the mesh ↓↓↓ if comment dont push UP and DOWN another time
  if      (k == UP) NORTH = false;
  else if (k == DOWN) SOUTH = false;
  else if (k == LEFT) WEST  = false;
  else if (k == RIGHT) EAST  = false;
  else if (k == SHIFT) SHIFTPRESSED = false;*/
}

void rotate2D(PVector v, float theta)
{
  float xTemp = v.x;
  v.x = v.x*cos(theta) - v.y*sin(theta);
  v.y = xTemp*sin(theta) + v.y*cos(theta);
}
