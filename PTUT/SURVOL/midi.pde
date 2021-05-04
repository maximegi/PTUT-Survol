void controllerChange(int channel, int number, int value) {
  ccChannel = channel;
  ccNumber = number;
  ccValue = value;

  cc[number] = value;

  // Boutons - 1ère ligne
  // Reset - Orientation de la caméra
  if (number==65) {
    mesh.deltaAngle = 0.05;
  }

  // Reset - Seuil de l'eau
  if (number==66) {
    texturedTerrain.m_waterThreshold = -0.2;
    float val = map(-0.2, -0.4, 0.4, 0, 127);
    myBus.sendControllerChange(0, 2, val);
  }

  // Reset - Seuil du sable
  if (number==67) {
    texturedTerrain.m_sandThreshold = 0.05;
  }

  // Reset - Seuil de la terre
  if (number==68) {
    texturedTerrain.m_clayThreshold = 0.1;
  }

  // Reset - Seuil de l'herbe
  if (number==69) {
    texturedTerrain.m_grassThreshold = 0.1;
  }

  // Boutons - 2ème ligne
  // Changement de background
  if (number==73) {
    changeBackground();
  }

  // Afficher ou non l'eau
  if (number==74) {
    texturedTerrain.changeWaterStatus();
  }

  // Afficher ou non les arbres
  if (number==75) {
    texturedTerrain.showTree();
  }

  // Afficher les arbres selon la normale
  if (number==76) {
    if(normal){normal =false;}
    else{normal = true;}
  }


  // Encoder
  // Orientation de la cam
  if (number==1) {
    cc[1]= map(value, 0, 127, PI/mesh.deltaAngle, -PI/mesh.deltaAngle);
    mesh.rotatemArea(cc[1]*mesh.deltaAngle);
  }

  // Seuil de l'eau
  if (number==2) {
    cc[2]= map(value, 0, 127, -0.4, 0.4);
    texturedTerrain.m_waterThreshold = cc[2];
  }

  // Seuil du sable
  if (number==3) {
    cc[3]= map(value, 0, 127, -0.4, 0.4);
    texturedTerrain.m_sandThreshold = cc[3];
  }
}
