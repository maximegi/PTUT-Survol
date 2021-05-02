void mapCylinder(int cols, int rows, int r, int sizeNoise, float pasPerlin, MovingArea m_terrain, RefinedTerrain m_refinedTerrain){
  noStroke();
  scale(2);
  translate(-cols/2,rows/3);

  // We're working with a half cylinder
  float angle = 180.0/ cols;
  for(int j = 0; j < rows-1; j++)
  {
    beginShape(TRIANGLE_STRIP);
    for (int i = 0; i < cols; i++){
        //convert coordinate to cylinderspace
        float x = cos( radians( i * angle ) ) * r;
        float xf = cos( radians( (i+1) * angle ) ) * r;

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

        // Find right texturing
        color biome = m_refinedTerrain.getFillColor(currentHeight, perlinTexture(xperlinc, yperlinc));

        float value = (perlinTrees(xperlinc, yperlinc) + perlinTrees(xperlinf, yperlinf))/2;

        // Place trees only if the tree value is "true"
        if(tree){
          if ((int)(value/5) %31 == 0) {
              if (normal){
                texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +3, (x+xf)/2 ,radians((i-cols/2)*angle), texturedTerrain.m_actualTree+4);
              }
              else {
                  texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +3, (x+xf)/2, texturedTerrain.m_actualTree+4);
              }
          }
          if ((int)(value/5) %23 == 0) {
              if (normal){
                texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +3, (x+xf)/2 ,radians((i-cols/2)*angle), texturedTerrain.m_actualTree);
              }
              else {
                  texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +3, (x+xf)/2, texturedTerrain.m_actualTree);
              }
          }

          if ((int)(value/5) %29 == 0) {
              if (normal){
                texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +3, (x+xf)/2 ,radians((i-cols/2)*angle), texturedTerrain.m_actualTree+2);
              }
              else {
                  texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +3, (x+xf)/2, texturedTerrain.m_actualTree+2);
              }
          }

          if ((int)(value/8) %17 == 0) {
              if (normal){
                texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +2, (x+xf)/2 ,radians((i-cols/2)*angle), texturedTerrain.m_actualTree +5);
              }
              else {
                  texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2 +2, (x+xf)/2, texturedTerrain.m_actualTree +5);
              }
          }
        }

        //flat sea
        if(zp <= sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold){
          zp = sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold;
        }
        if(zf <= sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold){
          zf = sin( radians( i * angle ) ) * r + sizeNoise * m_refinedTerrain.m_waterThreshold;
        }

        fill(biome);
        vertex( yp, -zp, x);
        color biome2 = m_refinedTerrain.getFillColor(perlin(xperlinf, yperlinf), perlinTexture(xperlinf, yperlinf));
        fill(biome2);
        vertex( yf,  -zf, x);
    }
  endShape();
  }
}
