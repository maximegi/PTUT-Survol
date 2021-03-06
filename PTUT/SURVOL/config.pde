import themidibus.*;


MidiBus myBus;

// for the MIDI
int ccChannel;
int ccNumber;
int ccValue;
float cc[] = new float[256];

JSONArray values;

void initValues(){
  values = loadJSONArray("data/data.json");

  JSONObject settings = values.getJSONObject(0);
  scl = settings.getInt("scl");
  w = settings.getInt("w");
  h = settings.getInt("h");
  pasPerlin = settings.getFloat("pasPerlin");
  sizeNoise = settings.getInt("sizeNoise");
  cameraWidth = settings.getInt("cameraWidth");
  cameraHeight = settings.getInt("cameraHeight");
  eyeX = settings.getInt("eyeX");
  eyeY = settings.getInt("eyeY");
  paramEyeZ = settings.getFloat("paramEyeZ");
  centerX = settings.getInt("centerX");
  centerY = settings.getInt("centerY");
  centerZ = settings.getInt("centerZ");
  upX = settings.getInt("upX");
  upY = settings.getInt("upY");
  upZ = settings.getInt("upZ");
  waterThreshold = settings.getFloat("waterThreshold");
  sandThreshold = settings.getFloat("sandThreshold");
  clayThreshold = settings.getFloat("clayThreshold");
  grassThreshold = settings.getFloat("grassThreshold");
  treeDensity = settings.getInt("treeDensity");
  texturedTerrain.m_actualTree = settings.getInt("actualTree");
  mesh.deltaPos = settings.getFloat("deltaPos");
  mesh.deltaAngle = settings.getFloat("deltaAngle");

  // Initialisation de la console midi :
  // Encoder :
  // Seuil de l'eau
  float tmpWater = map(waterThreshold, -0.4, 0.4, 0, 127);
  myBus.sendControllerChange(0, 2, (int)tmpWater);
  // Seuil du sable
  float tmpSand = map(sandThreshold, -0.4, 0.6, 0, 127);
  myBus.sendControllerChange(0, 3, (int)tmpSand);
  // Seuil de la terre
  float tmpClay = map(clayThreshold, -0.4, 0.6, 0, 127);
  myBus.sendControllerChange(0, 4, (int)tmpClay);
  // Seuil de l'herbe
  float tmpGrass = map(grassThreshold, -0.4, 0.6, 0, 127);
  myBus.sendControllerChange(0, 5, (int)tmpGrass);
}

void exportValues(){
  JSONArray valuesExported = new JSONArray();
  JSONObject json = new JSONObject();
  json.setInt("scl",scl);
  json.setInt("w",w);
  json.setInt("h",h);
  json.setFloat("pasPerlin",pasPerlin);
  json.setInt("sizeNoise",sizeNoise);
  json.setFloat("cameraWidth",customCamera.cameraWidth);
  json.setFloat("cameraHeight",customCamera.cameraHeight);
  json.setFloat("eyeX",customCamera.eyeX);
  json.setFloat("eyeY",customCamera.eyeY);
  json.setFloat("paramEyeZ",customCamera.paramEyeZ);
  json.setFloat("centerX",customCamera.centerX);
  json.setFloat("centerY",customCamera.centerY);
  json.setFloat("centerZ",customCamera.centerZ);
  json.setFloat("upX",customCamera.upX);
  json.setFloat("upY",customCamera.upY);
  json.setFloat("upZ",customCamera.upZ);
  json.setFloat("waterThreshold",texturedTerrain.m_waterThreshold);
  json.setFloat("sandThreshold",texturedTerrain.m_sandThreshold);
  json.setFloat("clayThreshold",texturedTerrain.m_clayThreshold);
  json.setFloat("grassThreshold",texturedTerrain.m_grassThreshold);
  json.setInt("treeDensity",texturedTerrain.m_treeDensity);
  json.setInt("actualTree",texturedTerrain.m_actualTree);
  json.setFloat("deltaPos",mesh.deltaPos);
  json.setFloat("deltaAngle",mesh.deltaAngle);
  valuesExported.setJSONObject(0,json);
  saveJSONArray(valuesExported, "data/savedConfig.json");

}
