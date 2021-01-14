// J'ai commencé le code de la fonction qui mixera deux image

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

      imgFinale.pixels[loc]  = color((r/20*hauteur)+(r_2/20*(1-hauteur)), (g/20*hauteur)+(g_2/20*(1-hauteur)),(b/20*hauteur)+(b_2/20*(1-hauteur)));
    }
  }
  //imgFinale.updatePixels();
  return imgFinale;

}
