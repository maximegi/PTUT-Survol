class Camera {
  //parameters
  float cameraWidth = 800;
  float cameraHeight = 800;
  float eyeX = 0;//cameraWidth/2;
  float eyeY = 0;//cameraHeight/2;
  float eyeZ = 0.7*(cameraHeight/2)/tan(PI/6);
  float centerX = 0;//cameraWidth/2;
  float centerY = 0;//cameraHeight/2;
  float centerZ = 0;
  float upX = 0;
  float upY = 1;
  float upZ = 0;


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
    if (key == 'e')
    {
      this.centerY += 1.0;
    }
    else if (key == 'd')
    {
      this.centerY -= 1.0;
    }

    else if (key == 'z')
    {
      this.eyeY += 1.0;
    }
    else if (key == 's')
    {
      this.eyeY -= 1.0;
    }
  }
}
