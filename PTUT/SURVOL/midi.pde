void controllerChange(int channel, int number, int value) {
  ccChannel = channel;
  ccNumber = number;
  ccValue = value;

  cc[number] = value;


  // Boutons - 1ère ligne
  // Reset - Orientation de la caméra
  if (number==65) {
    mesh.deltaAngle = 0.0;
  }

  // Reset - Seuil de l'eau
  if (number==66) {
    texturedTerrain.m_waterThreshold = -0.2;
    float val = map(-0.2, -0.4, 0.4, 0, 127);
    myBus.sendControllerChange(0, 2, (int)val);
  }

  // Reset - Seuil du sable
  if (number==67) {
    texturedTerrain.m_sandThreshold = 0.05;
    float val = map(0.05, -0.4, 0.6, 0, 127);
    myBus.sendControllerChange(0, 3, (int)val);
  }

  // Reset - Seuil de la terre
  if (number==68) {
    texturedTerrain.m_clayThreshold = 0.1;
    float val = map(0.1, -0.4, 0.6, 0, 127);
    myBus.sendControllerChange(0, 4, (int)val);
  }

  // Reset - Seuil de l'herbe
  if (number==69) {
    texturedTerrain.m_grassThreshold = 0.1;
    float val = map(0.1, -0.4, 0.6, 0, 127);
    myBus.sendControllerChange(0, 5, (int)val);
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
    cc[1]= map(value, 0, 127, -PI, PI);
    mesh.deltaAngle = cc[1]/50;
  }

  // Seuil de l'eau
  if (number==2) {
    cc[2]= map(value, 0, 127, -0.4, 0.4);
    texturedTerrain.m_waterThreshold = cc[2];
  }

  // Seuil du sable
  if (number==3) {
    cc[3]= map(value, 0, 127, -0.4, 0.6);
    texturedTerrain.m_sandThreshold = cc[3];
  }

  // Seuil de la terre
  if (number==4) {
    cc[4]= map(value, 0, 127, -0.4, 0.6);
    texturedTerrain.m_clayThreshold = cc[4];
  }

  // Seuil de l'herbe
  if (number==5) {
    cc[5]= map(value, 0, 127, -0.4, 0.6);
    texturedTerrain.m_grassThreshold = cc[5];
  }


  // Slider
  // Vitesse de défilement
  if (number==81) {
    cc[81]= map(value, 0, 127, 10, -10);
    mesh.deltaPos = (int)cc[81];
  }

    // Reset - Parametre de Cam
    if (number==79) {
      customCamera.eyeY = eyeY;
      customCamera.paramEyeZ = paramEyeZ;
      customCamera.centerX = centerX;
      customCamera.centerY = centerY;
    }

    // eyeY
    if (number==83) {
      cc[83]= map(value, 0, 127, 24, -128);
      customCamera.eyeY = cc[83];
    }

    // paramEyeZ
    if (number==84) {
      cc[84]= map(value, 0, 127, 1, 0.5);
      customCamera.paramEyeZ = cc[84];
      customCamera.eyeZ = customCamera.paramEyeZ*(customCamera.cameraHeight/2)/tan(PI/6);
    }

    // centerY
    if (number==85) {
      cc[85]= map(value, 0, 127, -4, 64);
      customCamera.centerY = cc[85] * 2;
    }

    // centerX
    if (number==86) {
      cc[86]= map(value, 0, 127, -64, 64);
      customCamera.centerX = cc[86] * 2;
    }

    // pasPerlin
    if (number==88) {
      cc[88]= map(value, 0, 127, -10, 10);
      pasPerlin = cc[88]/70;
    }

    // Reset pasPerlin
    if (number==80) {
      pasPerlin = 0.01;
    }

}
