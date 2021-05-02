class Camera {
  //parameters
  float cameraWidth = 800;
  float cameraHeight = 800;
  float eyeX = 0;//cameraWidth/2;
  float eyeY = 0;//cameraHeight/2;
  float eyeZ = 0;
  float paramEyeZ = 0;
  float centerX = 0;//cameraWidth/2;
  float centerY = 0;//cameraHeight/2;
  float centerZ = 0;
  float upX = 0;
  float upY = 1;
  float upZ = 0;

  void initCam(float cameraWidth, float cameraHeight, float eyeX, float eyeY, float paramEyeZ,
              float centerX, float centerY, float centerZ, float upX, float upY, float upZ){
    this.cameraWidth = cameraWidth;
    this.cameraHeight = cameraHeight;
    this.eyeX = eyeX;
    this.eyeY = eyeY;
    this.paramEyeZ = paramEyeZ;
    this.eyeZ = this.paramEyeZ*(cameraHeight/2)/tan(PI/6);
    this.centerX = centerX;
    this.centerY = centerY;
    this.centerZ = centerZ;
    this.upX = upX;
    this.upY = upY;
    this.upZ = upZ;

  }
  void useCam(){
    camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }

  void update(){
    //processMouseEvent();
    processKeyboardEvent();
  };

  void processMouseEvent(){
    this.centerX = mouseX;
  }

  void processKeyboardEvent(){
    if (key == 'o')
    {
      this.centerY += 2.0;
    }
    if (key == 'l')
    {
      this.centerY -= 2.0;
    }

    if (key == '1')
    {
      this.centerZ += 1.0;
    }
    if (key == '4')
    {
      this.centerZ -= 1.0;
    }

    // Faire pencher la caméra vers la gauche ou la droite
    if (key == 'k')
    {
      this.centerX += 2.0;
    }
    if (key == 'm')
    {
      this.centerX -= 2.0;
    }

    // Approcher la caméra vers l'avant
    if (key == 'z')
    {
      this.eyeY += 2.0;
    }
    if (key == 's')
    {
      this.eyeY -= 1.0;
    }

    // Déplacer la caméra vers la gauche ou la droite tout en se penchant
    if (key == 'q')
    {
      this.eyeX += 5.0;
    }
    if (key == 'd')
    {
      this.eyeX -= 5.0;
    }

    if (key == '5')
    {
      this.paramEyeZ += 0.01;
      this.eyeZ = this.paramEyeZ*(this.cameraHeight/2)/tan(PI/6);
    }
    if (key == '2')
    {
      this.paramEyeZ -= 0.01;
      this.eyeZ = this.paramEyeZ*(cameraHeight/2)/tan(PI/6);
    }
  }
}
