public class Camera {
  //parameters
  public float cameraWidth = 800;
  public float cameraHeight = 800;
  public float eyeX = 0;//cameraWidth/2;
  public float eyeY = 0;//cameraHeight/2;
  public float eyeZ = (cameraHeight/2)/tan(PI/6);
  public float centerX = 0;//cameraWidth/2;
  public float centerY = 0;//cameraHeight/2;
  public float centerZ = 0.0;
  public float upX = 0;
  public float upY = 1;
  public float upZ = 0;


  void useCam(){
    camera(eyeX,eyeY,eyeZ,centerX,centerY,centerZ,upX,upY,upZ);
  }
}
