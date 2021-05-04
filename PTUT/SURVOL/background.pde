PGraphics sky;
int bgSelect = 0;

// Generation of a sky background
void createSky(){
  sky.beginDraw();
  sky.noStroke();
  sky.rect(0,0, width,3*height/4);
  for (float i = 0; i < 3*height/4; i += step) {
    for (float j = 0; j < width; j += step) {
      float n = noise(j/200., i/50.);
      //sky.fill(9, 177, 236, n*map(i, 0, 3*height/4, 255, 0));
      sky.fill(58, 163, 190, n*map(i, 0, 3*height/4, 255, 220));
      sky.rect(j,i, step,step);
    }
  }
  sky.endDraw();
}

// Show current background
void showBackground(){
  if(bgSelect == 0){
    background(sky);
  }
  else if(bgSelect == 1){
    background(255);
  }
  else{
    background(0);
  }
}

// Change background
void changeBackground(){
    if(bgSelect == 2){
      bgSelect = 0;
    }
    else{
      bgSelect ++;
    }
}
