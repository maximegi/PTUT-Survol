void drawPlanar(int cols, int rows, int sizeNoise, float pasPerlin, Terrain m_terrain){
  camera(camera.eyeX,camera.eyeY,camera.eyeZ,camera.centerX,camera.centerY,camera.centerZ,camera.upX,camera.upY,camera.upZ);
  camera.update();
  //translate(width/4,height/2);
  background(100);
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  //z axis
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
  stroke(255);
  noFill();

  noStroke();
  //directionalLight(102, 202, 186, 1, 1, 0);
  //ambientLight(30, 30, 30);

  for(int j = 0; j < rows-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //cartesian coordinates
        float x = i;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        // current vertice's height
        float currentHeight = perlin(m_terrain.x() +i*pasPerlin, m_terrain.y() + j*pasPerlin);
        //z past
        float zp = sizeNoise * currentHeight;
        //z future
        float zf = perlin(m_terrain.x() +i*pasPerlin, m_terrain.y() + (j+1)*pasPerlin) * sizeNoise;

        // fill terrain with the appropriate color
        color biome = getBiome(currentHeight,terrainTexture[i][j], true);
        fill(biome);

        vertex( yp, -zp, x);
        vertex( yf,  -zf, x);
    }
    endShape();
  }
}

void mapCylinder(int cols, int rows, int r, int sizeNoise, float pasPerlin, Terrain m_terrain){
  camera(camera.eyeX,camera.eyeY,camera.eyeZ,camera.centerX,camera.centerY,camera.centerZ,camera.upX,camera.upY,camera.upZ);
  camera.update();
  //translate(width/4,height/2);
  background(100,100,100);
  stroke(255, 0, 0);
  line(-1000, 0, 0, 1000, 0, 0);
  //y axis
  stroke(0, 255, 0);
  line(0, -1000, 0, 0, 1000, 0);
  //z axis
  stroke(0, 0, 255);
  line(0, 0, -1000, 0, 0, 1000);
  stroke(255);
  noFill();

  noStroke();
  //directionalLight(102, 202, 186, 1, 1, 0);
  //ambientLight(30, 30, 30);

  //we're working with a half cylinder
  float angle = 180.0 / cols;

  for(int j = 0; j < rows-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //convert coordinate to cylinderspace
        float x = cos( radians( i * angle ) ) * r;
        //y past
        float yp = j;
        //y future
        float yf = j+1;
        // current vertice's height
        float currentHeight = perlin(m_terrain.x() +i*pasPerlin, m_terrain.y() + j*pasPerlin);
        //z past
        float zp = sin( radians( i * angle ) ) * r + currentHeight * sizeNoise;
        //z future
        float zf = sin( radians( i * angle ) ) * r + perlin(m_terrain.x() +i*pasPerlin, m_terrain.y() + (j+1)*pasPerlin) * sizeNoise;

        // fill terrain with the appropriate color
        color biome = getBiome(currentHeight,terrainTexture[i][j], true);
        fill(biome);
        // add trees
        // il faudra faire une fonction plaçant les arbres, elle devra prendre en paramètres : le terrain (pour accèder à la liste d'abres associés),
        // le nom du biome (pour varier la densité en fonction du biome : sable, eau, herbe, terre ou en focntion de la hauteur), la position de la vertice

        vertex( yp, -zp, x);
        vertex( yf,  -zf, x);
    }
    endShape();
  }
}
