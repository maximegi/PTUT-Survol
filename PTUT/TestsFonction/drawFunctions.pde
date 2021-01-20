void drawPlanar(PGraphics pg, int cols, int rows, int sizeNoise, float pasPerlin, Terrain m_terrain){
  pg.camera(camera.eyeX,camera.eyeY,camera.eyeZ,camera.centerX,camera.centerY,camera.centerZ,camera.upX,camera.upY,camera.upZ);
  camera.update();
  pg.beginDraw();
  //pg.translate(width/4,height/2);
  pg.background(100);
  pg.stroke(255, 0, 0);
  pg.line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  pg.stroke(0, 255, 0);
  pg.line(0, -1000, 0, 0, 1000, 0);
  //z axis
  pg.stroke(0, 0, 255);
  pg.line(0, 0, -1000, 0, 0, 1000);
  pg.stroke(255);
  pg.noFill();

  pg.noStroke();
  //pg.directionalLight(102, 202, 186, 1, 1, 0);
  //pg.ambientLight(30, 30, 30);

  for(int j = 0; j < rows-1; j++)
  {
    pg.beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //cartesian coordinates
        float x = i;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = perlin(m_terrain.x(), i, m_terrain.y(), j, sizeNoise, pasPerlin);
        //z future
        float zf = perlin(m_terrain.x(), i, m_terrain.y(), j+1, sizeNoise, pasPerlin);

        pg.fill(getBiome(perlin(m_terrain.x(), i, m_terrain.y(), j, sizeNoise, pasPerlin),terrainTexture[i][j], true));

        float ran = map(perlin(m_terrain.x(), i, m_terrain.y(), j, sizeNoise, pasPerlin), -sizeNoise, sizeNoise, 0, 100);
        //println(ran);
        if(ran <= 30){
          pg.pushMatrix();
          //translate(+rows/2,0);
          pg.rotateX(PI/2);
          //translate(-yp + cols/2,zp + offsetTree,x);
          pg.translate(x-rows/2,zp + offsetTree,-yp + cols/2);
          //pg.translate(yp,-zp+ offsetTree,x);
          pg.scale(2);
          pg.fill(0,255,0);
          pg.shape(tree);
          pg.popMatrix();
        }

        pg.vertex( yp, -zp, x);

        pg.vertex( yf,  -zf, x);
    }
    pg.endShape();
  }
  pg.endDraw();
}

void mapCylinder(PGraphics pg, int cols, int rows, int r, int sizeNoise, float pasPerlin, Terrain m_terrain){
  pg.camera(camera.eyeX,camera.eyeY,camera.eyeZ,camera.centerX,camera.centerY,camera.centerZ,camera.upX,camera.upY,camera.upZ);
  camera.update();
  pg.beginDraw();
  //pg.translate(width/4,height/2);
  pg.background(0);
  pg.stroke(255, 0, 0);
  pg.line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  pg.stroke(0, 255, 0);
  pg.line(0, -1000, 0, 0, 1000, 0);
  //z axis
  pg.stroke(0, 0, 255);
  pg.line(0, 0, -1000, 0, 0, 1000);
  pg.stroke(255);
  pg.noFill();

  pg.noStroke();
  //pg.directionalLight(102, 202, 186, 1, 1, 0);
  //pg.ambientLight(30, 30, 30);

  //we're working with a half cylinder
  float angle = 180.0 / cols;

  for(int j = 0; j < rows-1; j++)
  {
    pg.beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //convert coordinate to cylinderspace
        float x = cos( radians( i * angle ) ) * r;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = sin( radians( i * angle ) ) * r + perlin(m_terrain.x(), i, m_terrain.y(), j, sizeNoise, pasPerlin);
        //z future
        float zf = sin( radians( i * angle ) ) * r + perlin(m_terrain.x(), i, m_terrain.y(), j+1, sizeNoise, pasPerlin);
        pg.fill(getBiome(perlin(m_terrain.x(), i, m_terrain.y(), j, sizeNoise, pasPerlin),terrainTexture[i][j], true));
        pg.vertex( yp, -zp, x);
        pg.vertex( yf,  -zf, x);
    }
    pg.endShape();
  }
  pg.endDraw();
}
