
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
  uv = new Scene(1);
  uv.createUv();

  gradient = new Scene(2);
  gradient.createGradient();

  redSphere= new Scene(3);
  redSphere.createRedSphere();

  normalSphere= new Scene(4);
  normalSphere.createNormalSphere();

  normalGround = new Scene(5);
  normalGround.createNormalGround(1);

  antiAliasing = new Scene(6);
  antiAliasing.createNormalGround(10);

  unitRender = new Scene(7);
  unitRender.createUnitRender();

  gammaRender = new Scene(8);
  gammaRender.createGammaRender();

  normalizedRender = new Scene(9);
  normalizedRender.createNormalizedRender();

  hemiSphereRender = new Scene(10);
  hemiSphereRender.createHemisphereRender();

  Metal = new Scene(11);
  Metal.createMetal();

  fuzzyMetal = new Scene(12);
  fuzzyMetal.createFuzzyMetal();

  dielectric = new Scene(13);
  dielectric.createDielectric();

  reflect = new Scene(14);
  reflect.createReflect();

  hollowGlass = new Scene(15);
  hollowGlass.createHollowGlass();

  blueRed = new Scene(16);
  blueRed.createBlueRed();

  distantView = new Scene(17);
  distantView.createDistantView();

  zoom = new Scene(18);
  zoom.createZoom();

  defocusBlur = new Scene(19);
  defocusBlur.createDefocusBlur();

  finalScene = new Scene(20);
  finalScene.createFinalScene();

  // Set the default scene to be the zoomed one
  changeScene(zoom);

  // Set the frame rate high
  frameRate(500);
}

// Put pixel on screen at x, y with color rgb and gamma corection
void setPixel(int x, int y, Vector3 rgb, int nSamples, boolean gammaCorection) {

  // Get vector values
  float r = rgb.x;
  float g = rgb.y;
  float b = rgb.z;

  // Scale to average into a color, based on number of samples
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
  } else if (currentScene == normalSphere|| currentScene == normalGround || currentScene == antiAliasing || currentScene == gradient) {
    normalLoop(currentScene);
  } else if (currentScene == unitRender) {
    UNHLoop(currentScene, false, 0, 'u');
  } else if (currentScene == gammaRender) {
    UNHLoop(currentScene, true, 0, 'u');
  } else if (currentScene == normalizedRender) {
    UNHLoop(currentScene, true, 0.001, 'n');
  } else if (currentScene == hemiSphereRender) {
    UNHLoop(currentScene, true, 0.001, 'h');
  } else {
    defaultLoop(currentScene);
  }
}

// What to do when changing scenes
void changeScene(Scene scene) {
  currentScene = scene;
  currentScene.changeScene();
}

// Change the number of samples per pixel (changing the quality of the image)
// For the final scene, also change the screen size
// Update the variables of the scene
void updateQuality(int quality, int finalSceneSize) {

  // Update the number of samples per pixel
  currentScene.nSamplesPixel = quality;

  // If it's the final scene, change the size
  if (currentScene == finalScene) {
    currentScene.changeScreenSize(finalSceneSize);
  }

  // Updates the variables needed
  currentScene.drawLine = currentScene.h;
  currentScene.changeScene();
}

// If we press a key
void keyPressed() {

  // If '+', '=' or '-', change the quality (doesn't apply for the scene with 1 nSamplesPixel at start (first few scenes only))
  if (currentScene.nSamplesPixel != 1) {
    if (key == '-') {
      updateQuality(10, 400);
    } else if (key == '=') {
      updateQuality(100, 800);
    } else if (key == '+') {
      updateQuality(500, 1200);
    }
  }

  // If the 'Enter' key is pressed, take a screenshot
  if (key == ENTER || key == RETURN) {
    saveFrame("images/scene-" + nf(currentScene.numberScene, 2) + "-quality-" + nf(currentScene.nSamplesPixel, 3) + ".png");
  }

  // Change to the corresponding scene from 'A' to 'T'
  if (key == 'a' || key == 'A') {
    changeScene(uv);
  } else if (key == 'b' || key == 'B') {
    changeScene(gradient);
  } else if (key == 'c' || key == 'C') {
    changeScene(redSphere);
  } else if (key == 'd' || key == 'D') {
    changeScene(normalSphere);
  } else if (key == 'e' || key == 'E') {
    changeScene(normalGround);
  } else if (key == 'f' || key == 'F') {
    changeScene(antiAliasing);
  } else if (key == 'g' || key == 'G') {
    changeScene(unitRender);
  } else if (key == 'h' || key == 'H') {
    changeScene(gammaRender);
  } else if (key == 'i' || key == 'I') {
    changeScene(normalizedRender);
  } else if (key == 'j' || key == 'J') {
    changeScene(hemiSphereRender);
  } else if (key == 'k' || key == 'K') {
    changeScene(Metal);
  } else if (key == 'l' || key == 'L') {
    changeScene(fuzzyMetal);
  } else if (key == 'm' || key == 'M') {
    changeScene(dielectric);
  } else if (key == 'n' || key == 'N') {
    changeScene(reflect);
  } else if (key == 'o' || key == 'O') {
    changeScene(hollowGlass);
  } else if (key == 'p' || key == 'P') {
    changeScene(blueRed);
  } else if (key == 'q' || key == 'Q') {
    changeScene(distantView);
  } else if (key == 'r' || key == 'R') {
    changeScene(zoom);
  } else if (key == 's' || key == 'S') {
    changeScene(defocusBlur);
  } else if (key == 't' || key == 'T') {
    changeScene(finalScene);
  }
}
