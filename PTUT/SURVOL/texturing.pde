color grass = color(63,101,29);
color grassTmp = color(0,0,0);

color clay = color(158,127,79);
color clayTmp = color(0,0,0);

color sand = color(229,217,194);
color sandTmp = color(0,0,0);

color water = color(45,127,150);;
color waterTmp = color(0,0,0);

color getBiome(float altitude, float m, boolean isWaterActive){
  //altitude = map(altitude, -20.0, 20, -1, 1);
  float waterThreshold = -1;

  if(isWaterActive){
    waterThreshold = -0.2;
  }

  if(altitude <= waterThreshold){
    waterTmp = color( red(water), green(water) , map(altitude, -1, waterThreshold, 1.5, 0.9) * blue(water));
    return waterTmp;
  }

  if(altitude <= waterThreshold+0.05){
    sandTmp = sand;
    return sandTmp;
  }

  if(altitude <= waterThreshold+0.1){
    clayTmp = color( red(clay), green(clay) * map(altitude, waterThreshold + 0.05, waterThreshold + 0.1, 1, 1.12) , blue(clay));
    return clayTmp;
  }

  if(altitude<=0.4){
    grassTmp = color( red(grass) * m, green(grass) * map(altitude, waterThreshold + 0.1, 0.4, 1, 0.8), blue(grass));
    return grassTmp;
  }

  if(altitude <=0.6){
    grassTmp = color( red(grass) * m, green(grass) * altitude, blue(grass) * altitude);
    return grassTmp;
  }

  return grass;
}
/*
void treePlacement(){

  for (int y = 0; y < height; y++) {
    for (int x = 0; x < width; x++) {
      double nx = x/width - 0.5, ny = y/height - 0.5;
      // blue noise is high frequency; try varying this
      bluenoise[y][x] = noise(50 * nx, 50 * ny);
    }
  }

  for (int yc = 0; yc < height; yc++) {
    for (int xc = 0; xc < width; xc++) {
      double max = 0;
      // there are more efficient algorithms than this
      for (int yn = yc - R; yn <= yc + R; yn++) {
        for (int xn = xc - R; xn <= xc + R; xn++) {
          if (0 <= yn && yn < height && 0 <= xn && xn < width) {
            double e = bluenoise[yn][xn];
            if (e > max) { max = e; }
          }
        }
      }
      if (bluenoise[yc][xc] == max) {
        // place tree at xc,yc
      }
    }
}
}*/
