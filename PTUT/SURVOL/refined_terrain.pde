class RefinedTerrain{
    boolean isWaterActive = true;

    float m_waterThreshold = -0.2;
    float m_sandThreshold = 0.05;
    float m_clayThreshold = 0.05;

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
      if(altitude <= this.m_waterThreshold && this.isWaterActive){
        waterTmp = color( red(water), green(water) , map(altitude, -1, this.m_waterThreshold, 1.5, 0.9) * blue(water));
        return waterTmp;
      }

      if(altitude <= (this.m_waterThreshold + this.m_sandThreshold)  && this.isWaterActive){
        sandTmp = sand;
        return sandTmp;
      }

      if(altitude <= (this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold) && this.isWaterActive){
        clayTmp = color( red(clay), green(clay) * map(altitude, this.m_waterThreshold + this.m_sandThreshold, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 1, 1.12) , blue(clay));
        return clayTmp;
      }

      if(altitude<=0.4){
        grassTmp = color( red(grass) * perlinTextureValue, green(grass) * map(altitude, this.m_waterThreshold + this.m_sandThreshold + this.m_clayThreshold, 0.4, 1, 0.8), blue(grass));
        return grassTmp;
      }

      if(altitude <=0.6){
        grassTmp = color( red(grass) * perlinTextureValue, green(grass) * altitude, blue(grass) * altitude);
        return grassTmp;
      }

      return grass;
    }

    void placeTrees(color currentColor, float x, float y, float z){
      if(currentColor != waterTmp){
        pushMatrix();
        translate(x, y, z);
        rotateX(PI);
        scale(2);
        shape(this.trees.get(0));
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
        keyPressed = false;
      }

    }
}
