color eau = color(45,127,144);
color sable = color(229,217,194);
color herbe = color(38,62,14);
color herbe2 = color(116,142,64);
color herbe3 = color(180,191,65);
color terre = color(158,127,79);


color getBiome(float h, float m){
  if(h <= -5.0){
    return eau;
  }
  if(h <= -4.0){
    return sable;
  }
  if(h <= -3.0){
    return terre;
  }
  else{
    if(m <= 0.33){
      return herbe;
    }
    else if(m <= 0.9){
      return herbe2;
    }
    else{
      return herbe3;
    }
  }
}



/*// J'ai commencé le code de la fonction qui mixera deux image
PImage createImg(PImage img1, PImage img2, float hauteur){
  PImage imgFinale;
  imgFinale = createImage(width, height, ARGB);
  img1.loadPixels();
  img2.loadPixels();

 // On parcourt les pixels des deux images
  for (int x = 0; x < img1.width; x++) {
    for (int y = 0; y < img1.height; y++ ) {
      int loc = x + y*img1.width;
      float r = red   (img1.pixels[loc]);
      float g = green (img1.pixels[loc]);
      float b = blue  (img1.pixels[loc]);

      float r_2 = red   (img2.pixels[loc]);
      float g_2 = green (img2.pixels[loc]);
      float b_2 = blue  (img2.pixels[loc]);

      imgFinale.pixels[loc]  = color((r*hauteur)+(r_2*(1-hauteur)), (g*hauteur)+(g_2*(1-hauteur)),(b*hauteur)+(b_2*(1-hauteur)));
    }
  }
  //imgFinale.updatePixels();
  return imgFinale;
}*/
/*
PImage createImg(PImage img1, PImage img2, PImage img3, float hauteur){

  img1.loadPixels();
  img2.loadPixels();
  img3.loadPixels();

 // On parcourt les pixels des deux images
  for (int x = 0; x < img1.width; x++) {
    for (int y = 0; y < img1.height; y++ ) {
      int loc = x + y*img1.width;
      float r = red   (img1.pixels[loc]);
      float g = green (img1.pixels[loc]);
      float b = blue  (img1.pixels[loc]);

      float r_2 = red   (img2.pixels[loc]);
      float g_2 = green (img2.pixels[loc]);
      float b_2 = blue  (img2.pixels[loc]);

      img3.pixels[loc]  = color((r*hauteur)+(r_2*(1-hauteur)), (g*hauteur)+(g_2*(1-hauteur)),(b*hauteur)+(b_2*(1-hauteur)));
    }
  }
  img3.updatePixels();
  return img3;

}*/
