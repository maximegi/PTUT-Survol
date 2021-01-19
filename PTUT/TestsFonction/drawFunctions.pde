void drawPlanar(PGraphics pg, int cols, int rows, float[][]terrain){
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
  //pg.fill(0,180,0);
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
        float zp = terrain[i][j];
        //z future
        float zf = terrain[i][j+1];

        //triangle vertices
        /*pg.vertex( x, yp, zp);
        pg.vertex( x,  yf, zf);*/
        pg.fill(getBiome(terrain[i][j],terrainTexture[i][j], true));
        /*
        if(terrain[i][j] >7.0){
          //pg.texture(img2);
          pg.fill(255,255,255);
        }
        else if(terrain[i][j] < -7.0){
          //pg.texture(img2);
          pg.fill(eau);
        }
        else{
          //pg.texture(img1);
          pg.fill(80,400*(abs(terrain[i][j])/20),10);
        }*/
        //pg.texture(createImg(img1, img2, 0.5));
        //pg.texture(createImg(img1, img2, imgFinale, 0.5));
        //pg.texture(imgFinale);
        pg.vertex( yp, -zp, x);

        pg.vertex( yf,  -zf, x);
    }
    pg.endShape();
  }
  pg.endDraw();
}

void mapCylinder(PGraphics pg, int cols, int rows, int rayon, float[][]terrain){
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
  //pg.fill(0,180,0);
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
        float x = cos( radians( i * angle ) ) * rayon;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        //z past
        float zp = sin( radians( i * angle ) ) * (rayon + terrain[i][j]);
        //z future
        float zf = sin( radians( i * angle ) ) * (rayon + terrain[i][j+1]);
        //triangle vertices
        /*pg.vertex( x, yp, zp);
        pg.vertex( x,  yf, zf);*/
        pg.fill(getBiome(terrain[i][j], terrainTexture[i][j], true));
        pg.vertex( yp, -zp, x);
        pg.vertex( yf,  -zf, x);
    }
    pg.endShape();
  }
  pg.endDraw();
}
