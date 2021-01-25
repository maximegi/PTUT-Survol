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


    void initRefinedTerrain(float waterThreshold, float sandThreshold, float clayThreshold, int treeDensity){
      this.m_waterThreshold = waterThreshold;
      this.m_sandThreshold = sandThreshold;
      this.m_clayThreshold = clayThreshold;
      this.m_treeDensity = treeDensity;
    }

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
          waterTmp = color(red(water), 3*green(water) , 3* blue(water));
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

    void placeTrees(color currentColor, float x, float y, float z,float angle){
      if(currentColor != waterTmp && currentColor != sandTmp){
        pushMatrix();
        translate(x, y-2, z);
        rotateX(angle + PI);
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
        if(key == 'w'){
          this.changeWaterStatus();
        }
        if(key == 'x'){
          this.m_waterThreshold -= 0.05;
        }
        if(key == 'c'){
          this.m_waterThreshold += 0.05;
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
