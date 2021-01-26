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
        float value = perlinTrees(xperlinc, yperlinc);
        if ((int)(value/10) %11 == 0) {
            texturedTerrain.placeTrees(biome, yp, -zp, x);
        }

        vertex( yp, -zp, x);
        vertex( yf,  -zf, x);
    }
    endShape();
  }
}

void mapCylinder(int cols, int rows, int r, int sizeNoise, float pasPerlin, MovingArea m_terrain, RefinedTerrain m_refinedTerrain){
  //translate(width/4,height/2);
  //background(100,100,100);
  background(sky);


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
        //beginShape(QUADS);
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

        //float xperlinf2 = m_terrain.getX() + (((i+1 - cols/2) * pasPerlin * mesh.getDirX()) + ((j - rows/2) * pasPerlin * mesh.getOrthoX()));
        //float yperlinf2 = m_terrain.getY() + (((i+1 - cols/2) * pasPerlin * mesh.getDirY()) + ((j - rows/2) * pasPerlin * mesh.getOrthoY()));

        //float xperlinf3 = m_terrain.getX() + (((i+1 - cols/2) * pasPerlin * mesh.getDirX()) + ((j+1 - rows/2) * pasPerlin * mesh.getOrthoX()));
        //float yperlinf3 = m_terrain.getY() + (((i+1 - cols/2) * pasPerlin * mesh.getDirY()) + ((j+1 - rows/2) * pasPerlin * mesh.getOrthoY()));

        // current vertice's height
        float currentHeight = perlin(xperlinc, yperlinc);
        //float currentHeight2 = perlin(xperlinf3, yperlinf3);

        //z past
        float zp = sin( radians( i * angle ) ) * r + currentHeight * sizeNoise;
        //z future
        float zf = sin( radians( i * angle ) ) * r + perlin(xperlinf, yperlinf) * sizeNoise;

        //float zf2 = sin( radians((i+1) * angle ) ) * r + perlin(xperlinf2, yperlinf2) * sizeNoise;

        //float zf3 = sin( radians((i+1) * angle ) ) * r + perlin(xperlinf3, yperlinf3) * sizeNoise;

        // fill terrain with the appropriate color
        //color biome = m_refinedTerrain.getFillColor(currentHeight, perlinTexture(xperlinc, yperlinc));

        // add trees
        /*
        float value2 = perlinTrees(xperlinf3, yperlinf3);
        if ((int)(value2/10) %11 == 0) {
            texturedTerrain.placeTrees(biome2, yf, -zf3, xf);
        }*/

        // Triangle A

        color biome = m_refinedTerrain.getFillColor(perlin((xperlinc+xperlinf)/2, (yperlinc+yperlinf)/2), perlinTexture((xperlinc+xperlinf)/2, (yperlinc+yperlinf)/2));
        float value = (perlinTrees(xperlinc, yperlinc) + perlinTrees(xperlinf, yperlinf))/2;
        if ((int)(value/10) %11 == 0) {
            if (normal){
              texturedTerrain.placeTrees(biome, yp, -zp, x,radians((i-cols/2)*angle));
            }
            else {
                texturedTerrain.placeTrees(biome, (yp+yf)/2, (-zp-zf)/2, (x+xf)/2);
            }
        }
        /*
        color biome = m_refinedTerrain.getFillColor(currentHeight, perlinTexture(xperlinc, yperlinc));
        float value = perlinTrees(xperlinc, yperlinc) ;
        if ((int)(value/10) %11 == 0) {
            if (normal){
              texturedTerrain.placeTrees(biome, yp, -zp, x,radians((i-cols/2)*angle));
            }
            else {
                texturedTerrain.placeTrees(biome, yp, -zp, x);
            }
        }*/
        fill(biome);
        /*
        if(biome == waterTmp || biome == sandTmp){
          tint(biome);
          texture(img);
        }
        else{
          fill(biome);
        }*/

        vertex( yp, -zp, x, 0, 0);
        vertex( yf,  -zf, x, 418,0);
        /*
        vertex( yf, -zf3, xf, 418, 418);
        vertex( yp, -zf2, xf, 0 , 418);

        // Triangle B
        color biome2 = m_refinedTerrain.getFillColor(currentHeight2, perlinTexture(xperlinf3, yperlinf3));
        fill(biome2);
        vertex( yf, -zf3, xf);
        vertex( yf,  -zf, x);
        vertex( yp, -zf2, xf);


        endShape();*/
    }
  endShape();
  }
}
