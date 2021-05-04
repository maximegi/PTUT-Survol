class RefinedTerrain{
    boolean isWaterActive = true;

    float m_waterThreshold = -0.2;
    float m_sandThreshold = 0.05;
    float m_clayThreshold = 0.05;
    float m_grassThreshold = 0.1;

    int m_actualTree = 0;
    boolean tree = true;
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

    color getFillColor(float altitude, float perlinTextureValue){
      if(this.isWaterActive){
        if(altitude <= this.m_waterThreshold){
          float waterMap = map(altitude, -1, this.m_waterThreshold, 0.5, 3);
          waterTmp = color(water >> 16 & 0xFF, waterMap*(water >> 8 & 0xFF) , waterMap* (water & 0xFF));
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
        grassTmp = color((grass >> 16 & 0xFF) * perlinTextureValue, (grass >> 8 & 0xFF) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, m_grassThreshold, 1, 0.8), (grass & 0xFF));
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

    void placeTrees(color currentColor, float x, float y, float z,float angle, int nbTree){
      if(currentColor != waterTmp && currentColor != sandTmp){
        pushMatrix();
        translate(x, y-2, z);
        rotateX(angle + PI);
        scale(5);
        shape(this.trees.get(nbTree));
        popMatrix();
      }
    }
    void placeTrees(color currentColor, float x, float y, float z,  int nbTree){
      if(currentColor != waterTmp && currentColor != sandTmp){
        pushMatrix();
        translate(x, y-2, z);
        rotateX(PI);
        scale(5);
        shape(this.trees.get(nbTree));
        popMatrix();
      }
    }

    void changeWaterStatus(){
      if(this.isWaterActive){this.isWaterActive = false;}
      else{this.isWaterActive = true;}
    }

    void showTree(){
      if(tree){tree = false;}
      else{tree = true;}
    }

    void addTreeToList(String filename){
      this.trees.add(loadShape(filename));
    }

    void update(){
      if(keyPressed){
        if(key == '-' || key == '6'){
          this.showTree();
        }
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
          println(this.m_sandThreshold);
        }
        if(key == 'b' || key == 'B'){
          this.m_sandThreshold += 0.05;
          println(this.m_sandThreshold);
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
          if(this.m_actualTree != trees.size() - 2)    {this.m_actualTree++;}
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
        if (key == 'u' || key == 'U'){
          pasPerlin += 0.005;
        }
        if (key == 'j' || key == 'J'){
          pasPerlin -= 0.005;
        }
        keyPressed = false;
      }

    }
}
