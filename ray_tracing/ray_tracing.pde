
// The variables for the different scenes
Scene uv;
Scene gradient;
Scene redSphere;
Scene normalSphere;
Scene normalGround;
Scene antiAliasing;
Scene unitRender;
Scene gammaRender;
Scene normalizedRender;
Scene hemiSphereRender;
Scene Metal;
Scene fuzzyMetal;
Scene dielectric;
Scene reflect;
Scene hollowGlass;
Scene blueRed;
Scene distantView;
Scene zoom;
Scene defocusBlur;
Scene finalScene;

Scene currentScene;

/////////////////////////////////

// Setup
void setup() {

  // Setup all the scenes
  uv = new Scene();
  uv.createUv();

  gradient = new Scene();
  gradient.createGradient();

  redSphere= new Scene();
  redSphere.createRedSphere();

  normalSphere= new Scene();
  normalSphere.createNormalSphere();

  normalGround = new Scene();
  normalGround.createNormalGround(1);

  antiAliasing = new Scene();
  antiAliasing.createNormalGround(10);

  unitRender = new Scene();
  unitRender.createUnitRender();

  gammaRender = new Scene();
  gammaRender.createGammaRender();

  normalizedRender = new Scene();
  normalizedRender.createNormalizedRender();

  hemiSphereRender = new Scene();
  hemiSphereRender.createHemisphereRender();

  Metal = new Scene();
  Metal.createMetal();

  fuzzyMetal = new Scene();
  fuzzyMetal.createFuzzyMetal();

  dielectric = new Scene();
  dielectric.createDielectric();

  reflect = new Scene();
  reflect.createReflect();

  hollowGlass = new Scene();
  hollowGlass.createHollowGlass();

  blueRed = new Scene();
  blueRed.createBlueRed();

  distantView = new Scene();
  distantView.createDistantView();

  zoom = new Scene();
  zoom.createZoom();

  defocusBlur = new Scene();
  defocusBlur.createDefocusBlur();

  finalScene = new Scene();
  finalScene.createFinalScene();

  // Set the default scene to be the hollow glass one
  currentScene = hollowGlass;
  hollowGlass.changeScene();

  // Set the frame rate high
  frameRate(500);
}

// Put pixel on screen at x, y with color rgb and gamma corection
void setPixel(int x, int y, Vector3 rgb, int nSamples, boolean gammaCorection) {

  // Get vector values
  float r = rgb.x;
  float g = rgb.y;
  float b = rgb.z;

  // Scale to average into a color based on number of samples
  float scale = 1.0 / nSamples;

  // If we want gamma corection
  if (gammaCorection) {

    // Light a bit more the color and scale the color based on the number of samples per pixel
    r = sqrt(scale * r);
    g = sqrt(scale * g);
    b = sqrt(scale * b);

    // Map them between 0 and 256
    r = map(r, 0.0, 16.0, 0, 256);
    g = map(g, 0.0, 16.0, 0, 256);
    b = map(b, 0.0, 16.0, 0, 256);
  } else {

    // Scale the color based on the number of samples per pixel
    r *= scale;
    g *= scale;
    b *= scale;
  }

  // Create the final color of the pixel
  color finalColor = color(r, g, b);

  // Put the color on the screen at x, y and save it for the current scene
  set(x, height - y, finalColor);
  currentScene.scene[height - y][x] = finalColor;
}

// Draw the image
void draw() {

  // Choose the correct loop based on the current scene
  if (currentScene == uv) {
    uvLoop();
  } else if (currentScene == redSphere) {
    redSphereLoop(currentScene);
  } else if (currentScene == normalSphere|| currentScene == normalGround || currentScene == antiAliasing) {
    normalLoop(currentScene);
  } else if (currentScene == unitRender) {
    UNHLoop(currentScene, false, 'u');
  } else if (currentScene == gammaRender) {
    UNHLoop(currentScene, true, 'u');
  } else if (currentScene == normalizedRender) {
    UNHLoop(currentScene, true, 'n');
  } else if (currentScene == hemiSphereRender) {
    UNHLoop(currentScene, true, 'h');
  } else {
    defaultLoop(currentScene);
  }
}

void keyPressed() {

  // If '+', '=' or '-', change the number of samples per pixel (changing the quality of the image)
  // For the final scene, also change the screen size
  // Update the variables of the scene
  if (key == '+') {
    currentScene.nSamplesPixel = 500;
    if (currentScene == finalScene) {
      currentScene.changeScreenSize(1200);
    }
    currentScene.changeScene();
  } else if (key == '-') {
    currentScene.nSamplesPixel = 10;
    if (currentScene == finalScene) {
      currentScene.changeScreenSize(400);
    }
    currentScene.changeScene();
  } else if (key == '=') {
    currentScene.nSamplesPixel = 100;
    if (currentScene == finalScene) {
      currentScene.changeScreenSize(800);
    }
    currentScene.changeScene();
  }

  // Change to the corresponding scene from 'A' to 'T'
  if (key == 'a' || key == 'A') {
    currentScene = uv;
    uv.changeScene();
  } else if (key == 'b' || key == 'B') {
    currentScene = gradient;
    gradient.changeScene();
  } else if (key == 'c' || key == 'C') {
    currentScene = redSphere;
    redSphere.changeScene();
  } else if (key == 'd' || key == 'D') {
    currentScene = normalSphere;
    normalSphere.changeScene();
  } else if (key == 'e' || key == 'E') {
    currentScene = normalGround;
    normalGround.changeScene();
  } else if (key == 'f' || key == 'F') {
    currentScene = antiAliasing;
    antiAliasing.changeScene();
  } else if (key == 'g' || key == 'G') {
    currentScene = unitRender;
    unitRender.changeScene();
  } else if (key == 'h' || key == 'H') {
    currentScene = gammaRender;
    gammaRender.changeScene();
  } else if (key == 'i' || key == 'I') {
    currentScene = normalizedRender;
    normalizedRender.changeScene();
  } else if (key == 'j' || key == 'J') {
    currentScene = hemiSphereRender;
    hemiSphereRender.changeScene();
  } else if (key == 'k' || key == 'K') {
    currentScene = Metal;
    Metal.changeScene();
  } else if (key == 'l' || key == 'L') {
    currentScene = fuzzyMetal;
    fuzzyMetal.changeScene();
  } else if (key == 'm' || key == 'M') {
    currentScene = dielectric;
    dielectric.changeScene();
  } else if (key == 'n' || key == 'N') {
    currentScene = reflect;
    reflect.changeScene();
  } else if (key == 'o' || key == 'O') {
    currentScene = hollowGlass;
    hollowGlass.changeScene();
  } else if (key == 'p' || key == 'P') {
    currentScene = blueRed;
    blueRed.changeScene();
  } else if (key == 'q' || key == 'Q') {
    currentScene = distantView;
    distantView.changeScene();
  } else if (key == 'r' || key == 'R') {
    currentScene = zoom;
    zoom.changeScene();
  } else if (key == 's' || key == 'S') {
    currentScene = defocusBlur;
    defocusBlur.changeScene();
  } else if (key == 't' || key == 'T') {
    currentScene = finalScene;
    finalScene.changeScene();
  }
}
