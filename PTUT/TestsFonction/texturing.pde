
color eau = color(45,127,150);
color sable = color(229,217,194);
color herbeClaire = color(180,191,65);
color herbe = color(63,101,29);
color herbeFoncee = color(38,80,14);
color terre = color(158,127,79);



color getBiome(float h, float m, boolean water){
  h = map(h, -20.0, 20, -1, 1);
  float seuilEau = -1;

  if(water){
    seuilEau = -0.2;
  }

  if(h <= seuilEau){
    return color(red(eau),green(eau),map(h, -1, seuilEau, 1.5, 0.9)*blue(eau));
  }
  if(h <= seuilEau+0.05){
    return sable;
  }
  if(h <= seuilEau+0.1){
    //return terre;
    return color(red(terre),green(terre)*map(h, seuilEau+0.05, seuilEau+0.1, 1, 1.12),blue(terre));
  }
  if(h<=0.4){
    return color(red(herbe)*m,green(herbe)*map(h, seuilEau+0.1, 0.4, 1, 0.8),blue(herbe));
  }
  if(h <=0.6){
    return color(63*m, 101*h, 29*h);
  }
  return color(63, 101, 29);
}
