void drawPlanar(int cols, int rows, int sizeNoise, float pasPerlin, MovingArea m_terrain, RefinedTerrain m_refinedTerrain){
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
  translate(-cols/2,0);
  for(int j = 0; j < rows-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++)
    {
        //mesh grid
        float x = i;
        //y past
        float yp = j;
        //y future
        float yf = j+1;

        //compute xperlincurrent and yperlincurrent considering rotation from the center of the mesh
        float xperlinc = m_terrain.getX() + (((i - cols/2) * pasPerlin * mesh.getDirX()) + ((j - rows/2) * pasPerlin * mesh.getOrthoX()));
        float yperlinc = m_terrain.getY() + (((i - cols/2) * pasPerlin * mesh.getDirY()) + ((j - rows/2) * pasPerlin * mesh.getOrthoY()));
        //compute xperlinfutur and yperlinfutur considering rotation from the center of the mesh
        float xperlinf = m_terrain.getX() + (((i - cols/2) * pasPerlin * mesh.getDirX()) + ((j+1 - rows/2) * pasPerlin * mesh.getOrthoX()));
        float yperlinf = m_terrain.getY() + (((i - cols/2) * pasPerlin * mesh.getDirY()) + ((j+1 - rows/2) * pasPerlin * mesh.getOrthoY()));

        // current vertice's height
        float currentHeight = perlin(xperlinc, yperlinc);
        //z past
        float zp = sizeNoise * currentHeight;
        //z future
        float zf = perlin(xperlinf, yperlinf) * sizeNoise;

        // fill terrain with the appropriate color
        color biome = m_refinedTerrain.getFillColor(currentHeight, perlinTexture(m_terrain.getX() +i*pasPerlin, m_terrain.getY() + j*pasPerlin));
        fill(biome);

        //flat sea
        if(zp <= sizeNoise * m_refinedTerrain.m_waterThreshold){ zp = sizeNoise * m_refinedTerrain.m_waterThreshold;}
        if(zf <= sizeNoise * m_refinedTerrain.m_waterThreshold){ zf = sizeNoise * m_refinedTerrain.m_waterThreshold;}

        float value = perlinTrees(xperlinc, yperlinc);
        if ((int)(value/10) %11 == 0) {
            texturedTerrain.placeTrees(biome, yp, -zp, x);
        }
        /*
        double max = 0;
        for(int xn = i - m_refinedTerrain.m_treeDensity; xn <= i + m_refinedTerrain.m_treeDensity; xn++){
          for(int yn = j - m_refinedTerrain.m_treeDensity; yn <= j + m_refinedTerrain.m_treeDensity; yn++){
            float xtmp = xn*pasPerlin + m_terrain.getX();
            float ytmp = yn*pasPerlin + m_terrain.getY();
            if (0 <= yn && yn < rows && 0 <= xn && xn < cols) {
              double e = perlinTrees(xtmp, ytmp);
              if (e > max) { max = e; }

            }
          }
        }
        if (perlinTrees(m_terrain.getX() +i*pasPerlin, m_terrain.getY() + j*pasPerlin) == max) {
          //texturedTerrain.placeTrees(biome, yp, -zp, x);
        }
*/
        /*
        double max = 0;

        for(int xn = i - m_refinedTerrain.m_treeDensity; xn <= i + m_refinedTerrain.m_treeDensity; xn++){
          for(int yn = j - m_refinedTerrain.m_treeDensity; yn <= j + m_refinedTerrain.m_treeDensity; yn++){
            if (0 <= yn && yn < rows && 0 <= xn && xn < cols) {
              double e = perlinTrees(xn, yn);
              if (e > max) { max = e; }
            }
          }
        }
        if (perlinTrees(i, j) == max) {
          texturedTerrain.placeTrees(biome, yp, -zp, x);
        }*/

        vertex( yp, -zp, x);
        vertex( yf,  -zf, x);
    }
    endShape();
  }
}

void mapCylinder(int cols, int rows, int r, int sizeNoise, float pasPerlin, MovingArea m_terrain, RefinedTerrain m_refinedTerrain){
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
  //ambientLight(200, 200, 200);
  scale(2);
  translate(-cols/2,rows/3);
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

        //compute xperlincurrent and yperlincurrent considering rotation from the center of the mesh
        float xperlinc = m_terrain.getX() + (((i - cols/2) * pasPerlin * mesh.getDirX()) + ((j - rows/2) * pasPerlin * mesh.getOrthoX()));
        float yperlinc = m_terrain.getY() + (((i - cols/2) * pasPerlin * mesh.getDirY()) + ((j - rows/2) * pasPerlin * mesh.getOrthoY()));
        //compute xperlinfutur and yperlinfutur considering rotation from the center of the mesh
        float xperlinf = m_terrain.getX() + (((i - cols/2) * pasPerlin * mesh.getDirX()) + ((j+1 - rows/2) * pasPerlin * mesh.getOrthoX()));
        float yperlinf = m_terrain.getY() + (((i - cols/2) * pasPerlin * mesh.getDirY()) + ((j+1 - rows/2) * pasPerlin * mesh.getOrthoY()));

        // current vertice's height
        float currentHeight = perlin(xperlinc, yperlinc);
        //z past
        float zp = sin( radians( i * angle ) ) * r + currentHeight * sizeNoise;
        //z future
        float zf = sin( radians( i * angle ) ) * r + perlin(xperlinf, yperlinf) * sizeNoise;

        // fill terrain with the appropriate color
        color biome = m_refinedTerrain.getFillColor(currentHeight, perlinTexture(xperlinc, yperlinc));
        fill(biome);

        //flat sea
        if(zp <= sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold){
          zp = sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold;
        }
        if(zf <= sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold){
          zf = sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold;
        }

        // add trees

        float value = perlinTrees(xperlinc, yperlinc);
        if ((int)(value/10) %11 == 0) {
          if (normal){
            texturedTerrain.placeTrees(biome, yp, -zp, x,radians((i-cols/2)*angle));
          }
          else {
            texturedTerrain.placeTrees(biome, yp, -zp, x);
          }
        }
        /*
        double max = 0;
        for(int xn = i - m_refinedTerrain.m_treeDensity; xn <= i + m_refinedTerrain.m_treeDensity; xn++){
          for(int yn = j - m_refinedTerrain.m_treeDensity; yn <= j + m_refinedTerrain.m_treeDensity; yn++){
            float xtmp = xn*pasPerlin + m_terrain.getX();
            float ytmp = yn*pasPerlin + m_terrain.getY();
            if (0 <= yn && yn < rows && 0 <= xn && xn < cols) {
              double e = perlinTrees(xtmp, ytmp);
              if (e > max) { max = e; }

            }
          }
        }*//*
        if (perlinTrees(m_terrain.getX() +i*pasPerlin, m_terrain.getY() + j*pasPerlin) == max) {
          texturedTerrain.placeTrees(biome, yp, -zp, x);
        }/*

        //float result = isTree(m_terrain.getX(), m_terrain.getY(), j, i, m_refinedTerrain.m_treeDensity, pasPerlin);
        /*
        if (perlinTrees(m_terrain.getX() +i*pasPerlin, m_terrain.getY() + j*pasPerlin) >10) {
            texturedTerrain.placeTrees(biome, yp, -zp, x);
        }*/

        /*
        double max = 0;

        for(int xn = i - m_refinedTerrain.m_treeDensity; xn <= i + m_refinedTerrain.m_treeDensity; xn++){
          for(int yn = j - m_refinedTerrain.m_treeDensity; yn <= j + m_refinedTerrain.m_treeDensity; yn++){
            if (0 <= yn && yn < rows && 0 <= xn && xn < cols) {
              double e = perlinTrees(xn, yn);
              if (e > max) { max = e; }
            }
          }
        }
        if (perlinTrees(i, j) == max) {
          texturedTerrain.placeTrees(biome, yp, -zp, x);
        }*/
        //texturedTerrain.placeTrees(biome, yp, -zp, x);
        // il faudra faire une fonction plaçant les arbres, elle devra prendre en paramètres : le terrain (pour accèder à la liste d'abres associés),
        // le nom du biome (pour varier la densité en fonction du biome : sable, eau, herbe, terre ou en focntion de la hauteur), la position de la vertice

        vertex( yp, -zp, x);
        vertex( yf,  -zf, x);
    }
    endShape();
  }
}
