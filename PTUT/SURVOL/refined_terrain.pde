class RefinedTerrain{
    boolean isWaterActive = true;

    float m_waterThreshold = -0.2;
    float m_sandThreshold = 0.05;
    float m_clayThreshold = 0.05;
    float m_grassThreshold = 0.1;

    int m_actualTree = 0;

    boolean changingWater = false;

    int m_treeDensity = 3;

    ArrayList<PShape> trees = new ArrayList<PShape>();


    void initRefinedTerrain(float waterThreshold, float sandThreshold, float clayThreshold, float grassThreshold, int treeDensity){
      this.m_waterThreshold = waterThreshold;
      this.m_sandThreshold = sandThreshold;
      this.m_clayThreshold = clayThreshold;
      this.m_grassThreshold = grassThreshold;
      this.m_treeDensity = treeDensity;
    }

    /*
    color getFillColor(float altitude, float perlinTextureValue){
      if(this.isWaterActive){
        if(altitude <= this.m_waterThreshold){
          waterTmp = color(red(water), map(altitude, -1, this.m_waterThreshold, 0.5, 3)*green(water) , map(altitude, -1, this.m_waterThreshold, 0.5, 3) * blue(water));
          //waterTmp = color( red(water), green(water) , map(altitude, -1, this.m_waterThreshold, 0.9, 1.5) * blue(water));
          //return waterTmp;
		      //waterTmp = color(min(180,120-altitude*1.5),90,max(110,min(110,-40*altitude)+50+altitude));
          return waterTmp;
        }
        else if(altitude <= (this.m_waterThreshold + this.m_sandThreshold)){
          waterTmp = color(red(water), map(altitude - this.m_sandThreshold, -1, this.m_waterThreshold, 0.5, 3)*green(water) , map(altitude - this.m_sandThreshold, -1, this.m_waterThreshold, 0.5, 3) * blue(water));
          //waterTmp = color(red(water), 3*green(water) , 3* blue(water));
          sandTmp = sand;
          sandTmp = lerpColor(waterTmp, sandTmp, map(altitude, this.m_waterThreshold, this.m_waterThreshold + this.m_sandThreshold, 0,1));
          return sandTmp;
        }
        else if(altitude <= (this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold)){
          sandTmp = sand;
          sandTmp = lerpColor(waterTmp, sandTmp, map(altitude, this.m_waterThreshold, this.m_waterThreshold + this.m_sandThreshold, 0,1));
          clayTmp = color( red(clay), green(clay) * map(altitude, this.m_waterThreshold + this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 1, 1.12) , blue(clay));
          clayTmp = lerpColor(sandTmp, clayTmp, map(altitude, this.m_waterThreshold+ this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0,1));
          return clayTmp;
        }
      }
      if(altitude<=m_grassThreshold){
        sandTmp = sand;
        clayTmp = clay;
        if(this.isWaterActive){
          sandTmp = lerpColor(waterTmp, sandTmp, map(altitude, this.m_waterThreshold, this.m_waterThreshold + this.m_sandThreshold, 0,1));
          clayTmp = color( red(clay), green(clay) * map(altitude, this.m_waterThreshold + this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 1, 1.12) , blue(clay));
          clayTmp = lerpColor(sandTmp, clayTmp, map(altitude, this.m_waterThreshold+ this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0,1));
        }
        grassTmp = color( red(grass) * perlinTextureValue, green(grass) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0.4, 1, 0.8), blue(grass));
        grassTmp = lerpColor(clayTmp, grassTmp, map(altitude, this.m_waterThreshold+ this.m_sandThreshold + this.m_clayThreshold, m_grassThreshold, 0,1));
        return grassTmp;
      }

      else if(altitude<=0.4){
        grassTmp = color( red(grass) * perlinTextureValue, green(grass) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0.4, 1, 0.8), blue(grass));
        return grassTmp;
      }

      else if(altitude <=0.6){
        grassTmp = color( red(grass) *(1- perlinTextureValue)  , green(grass) * altitude, blue(grass) * altitude);
        return grassTmp;
      }

      else {return grass;}
    }
    */

    color getFillColor(float altitude, float perlinTextureValue){
      if(this.isWaterActive){
        if(altitude <= this.m_waterThreshold){
          waterTmp = color(water >> 16 & 0xFF, map(altitude, -1, this.m_waterThreshold, 0.5, 3)*(water >> 8 & 0xFF) , map(altitude, -1, this.m_waterThreshold, 0.5, 3) * (water & 0xFF));
          return waterTmp;
        }
        else if(altitude <= (this.m_waterThreshold + this.m_sandThreshold)){
          color waterTmp2 = color(water >> 16 & 0xFF, 3*(water >> 8 & 0xFF) , 3* (water & 0xFF));
          sandTmp = lerpColor(waterTmp2, sand, map(altitude, this.m_waterThreshold, this.m_waterThreshold + this.m_sandThreshold, 0,1));
          return sandTmp;
        }

        else if(altitude <= (this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold)){
          clayTmp = lerpColor(sand, clay, map(altitude, this.m_waterThreshold+ this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0,1));
          return clayTmp;
        }
      }
      if(altitude<=m_grassThreshold){
        grassTmp = color((grass >> 16 & 0xFF) * perlinTextureValue, (grass >> 8 & 0xFF) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0.4, 1, 0.8), (grass & 0xFF));
        grassTmp = lerpColor(clay, grassTmp, map(altitude, this.m_waterThreshold+ this.m_sandThreshold + this.m_clayThreshold, m_grassThreshold, 0,1));
        return grassTmp;
      }

      else if(altitude<=0.5){
        grassTmp = color( (grass >> 16 & 0xFF) * perlinTextureValue, (grass >> 8 & 0xFF) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0.5, 1, 0.6), (grass & 0xFF));
        return grassTmp;
      }

      else{
        color grassTmp0 = color( (grass >> 16 & 0xFF) * perlinTextureValue, (grass >> 8 & 0xFF) *0.6, (grass & 0xFF));
        color grassTmp1 = color( 255*(1- 0.5*perlinTextureValue)  , (grass >> 8 & 0xFF) * altitude, (grass & 0xFF) * altitude);
        grassTmp1 = lerpColor(grassTmp0, grassTmp1, map(altitude, 0.5, 1, 0,1));
        return grassTmp1;
      }
    }

    void placeTrees(color currentColor, float x, float y, float z,float angle){
      if(currentColor != waterTmp && currentColor != sandTmp){
        pushMatrix();
        translate(x, y-2, z);
        rotateX(angle);
        scale(1.5);
        shape(this.trees.get(this.m_actualTree));
        popMatrix();
      }
    }
    void placeTrees(color currentColor, float x, float y, float z){
      if(currentColor != waterTmp && currentColor != sandTmp){
        pushMatrix();
        translate(x, y-2, z);
        rotateX(PI);
        scale(1.5);
        shape(this.trees.get(this.m_actualTree));
        popMatrix();
      }
    }

    void changeWaterStatus(){
      if(this.isWaterActive){this.isWaterActive = false;}
      else{this.isWaterActive = true;}
    }

    void addTreeToList(String filename){
      this.trees.add(loadShape(filename));
    }

    void update(){
      if(keyPressed){
        if(key == 'w' || key == 'W'){
          this.changeWaterStatus();
        }
        if(key == 'x' || key == 'X'){
          this.m_waterThreshold -= 0.05;
        }
        if(key == 'c' || key == 'C'){
          this.m_waterThreshold += 0.05;
        }
        if((key == 'v' || key == 'V') && this.m_sandThreshold!= 0.1){
          this.m_sandThreshold -= 0.05;
        }
        if(key == 'b' || key == 'B'){
          this.m_sandThreshold += 0.05;
        }
        if((key == 'n' || key == 'N') && this.m_clayThreshold!= 0.1){
          this.m_clayThreshold -= 0.05;
        }
        if(key == ',' || key == '?'){
          this.m_clayThreshold += 0.05;
        }
        if((key == ';' || key == '.') && this.m_grassThreshold!= 0.1){
          this.m_grassThreshold -= 0.05;
        }
        if(key == ':' || key == '/'){
          this.m_grassThreshold += 0.05;
        }
        if (key == '_' || key == '8'){//number 8 (above the I)
          if(this.m_actualTree != trees.size() - 1)    {this.m_actualTree++;}
          else {this.m_actualTree = 0;}
        }
        if (key == 'ç' || key == '9'){//number 9 (above the O)
          if(this.m_actualTree != 0){this.m_actualTree--;}
          else {this.m_actualTree =trees.size()-1;}
        }
        if (key == '*' || key == 'µ'){//number 9 (above the O)
          if(normal){normal =false;}
          else{normal = true;}
        }
        keyPressed = false;
      }

    }
}
