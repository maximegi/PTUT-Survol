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
  centerX = settings.getInt("centerX");
  centerY = settings.getInt("centerY");
  centerZ = settings.getInt("centerZ");
  upX = settings.getInt("upX");
  upY = settings.getInt("upY");
  upZ = settings.getInt("upZ");
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
  json.setFloat("centerX",customCamera.centerX);
  json.setFloat("centerY",customCamera.centerY);
  json.setFloat("centerZ",customCamera.centerZ);
  json.setFloat("upX",customCamera.upX);
  json.setFloat("upY",customCamera.upY);
  json.setFloat("upZ",customCamera.upZ);
  valuesExported.setJSONObject(0,json);
  saveJSONArray(valuesExported, "data/savedConfig.json");

}
