color eau = color(45,127,150);
color sable = color(229,217,194);
color herbeClaire = color(180,191,65);
color herbe = color(116,142,64);
color herbeFoncee = color(38,80,14);
color terre = color(158,127,79);


color getBiome(float h, float m){
  if(h <= -5.0){
    //return eau;
    return color(red(eau),green(eau),map(h, -20.0, -5.0, 1.5, 0.9)*blue(eau));
  }
  if(h <= -4.0){
    return sable;
  }
  if(h <= -3.0){
    //return terre;
    return color(red(terre),green(terre)*map(h, -3, -4, 1.12, 1),blue(terre));
  }
  if(h >= 8.0){
    //return herbeFoncee;
    return color(red(herbeFoncee),green(herbeFoncee)*map(h, 8.0, 20, 1, 0.2),blue(herbeFoncee));
  }
  else{
    if(m <= 0.5 || m>=0.99){
      //return herbeClaire;
      return color(red(herbeClaire)+(20*m),green(herbeClaire)*map(h, -3.0, 8.0, 1, 0.8),blue(herbeClaire));
    }
    else{
      //return herbe;
      return color(red(herbe)*m,green(herbe)*map(h, -3.0, 8.0, 1, 0.8),blue(herbe));
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
