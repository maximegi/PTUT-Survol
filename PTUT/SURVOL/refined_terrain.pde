class RefinedTerrain{
    boolean isWaterActive = true;

    float m_waterThreshold = -0.2;
    float m_sandThreshold = 0.05;
    float m_clayThreshold = 0.05;

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
          waterTmp = color( red(water), green(water) , map(altitude, -1, this.m_waterThreshold, 1.5, 0.9) * blue(water));
          return waterTmp;
        }
        else if(altitude <= (this.m_waterThreshold + this.m_sandThreshold)){
          sandTmp = sand;
          return sandTmp;
        }

        else if(altitude <= (this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold)){
          clayTmp = color( red(clay), green(clay) * map(altitude, this.m_waterThreshold + this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 1, 1.12) , blue(clay));
          return clayTmp;
        }
      }
      if(altitude<=0.4){
        grassTmp = color( red(grass) * perlinTextureValue, green(grass) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0.4, 1, 0.8), blue(grass));
        return grassTmp;
      }

      else if(altitude <=0.6){
        grassTmp = color( red(grass) * perlinTextureValue, green(grass) * altitude, blue(grass) * altitude);
        return grassTmp;
      }

      else {return grass;}
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
