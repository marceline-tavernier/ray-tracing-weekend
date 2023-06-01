float normalScreenRatio = 16.0 / 9.0;

Level uv;
Level gradient;
Level redSphere;
Level normalSphere;
Level normalGround;
Level antiAliasing;
Level unitRender;
Level gammaRender;
Level normalizedRender;
Level hemiSphereRender;
Level Metal;
Level fuzzedMetal;
Level Dielectric;
Level refract;
Level hollowGlass;
Level blueRed;
Level distantView;
Level zoom;
Level defocusBlur;
Level finalScene;

Level currentLevel;

/////////////////////////////////

// Setup
void setup() {
  
  uv = new Level(512, 1, 512);
  uv.createUv();
  
  gradient = new Level(800, 1, 800);
  gradient.createGradient();
  
  redSphere= new Level(800, 1, 100);
  redSphere.createRedSphere();
  
  normalSphere= new Level(800, 1, 10);
  normalSphere.createNormalSphere();
  
  normalGround = new Level(800, 1, 10);
  normalGround.createNormalGround();
  
  antiAliasing = new Level(800, 10, 1);
  antiAliasing.createNormalGround();
  
  unitRender = new Level(800, 10, 1);
  unitRender.createUnitRender();
  
  gammaRender = new Level(800, 10, 1);
  gammaRender.createGammaRender();
  
  normalizedRender = new Level(800, 10, 1);
  normalizedRender.createNormalizedRender();
  
  hemiSphereRender = new Level(800, 10, 1);
  hemiSphereRender.createHemiSphereRender();
  
  Metal = new Level(800, 10, 1);
  Metal.createMetal();
  
  fuzzedMetal = new Level(800, 10, 1);
  fuzzedMetal.createFuzzedMetal();
  
  Dielectric = new Level(800, 10, 1);
  Dielectric.createDielectric();
  
  refract = new Level(800, 10, 1);
  refract.createRefract();
  
  hollowGlass = new Level(800, 10, 1);
  hollowGlass.createHollowGlass();
  
  blueRed = new Level(800, 10, 1);
  blueRed.createBlueRed();
  
  distantView = new Level(800, 10, 1);
  distantView.createDistantView();
  
  zoom = new Level(800, 10, 1);
  zoom.createZoom();
  
  defocusBlur = new Level(800, 10, 1);
  defocusBlur.createDefocusBlur();
  
  finalScene = new Level(400, 5, 1);
  finalScene.createFinalScene();
  
  currentLevel = hollowGlass;
  hollowGlass.changeLevel();
  
  frameRate(300);
}

// Put pixel on screen at x, y with color rgb
void setPixel(int x, int y, Vector3 rgb, int nSamples, boolean gammaCorrection) {
  
  // Get vector values
  float r = rgb.x;
  float g = rgb.y;
  float b = rgb.z;

  // Scale to average into a color based on number of samples
  float scale = 1.0 / nSamples;
  if (gammaCorrection) {
  
    r = sqrt(scale * r);
    g = sqrt(scale * g);
    b = sqrt(scale * b);
    
    // Map them between 0 and 256
    r = map(r, 0.0, 16.0, 0, 256);
    g = map(g, 0.0, 16.0, 0, 256);
    b = map(b, 0.0, 16.0, 0, 256);
  } else {
    r *= scale;
    g *= scale;
    b *= scale;
  }

  color finalColor = color(r, g, b);
  // Put the color rgb on the screen at x, y
  set(x, height - y, finalColor);
  currentLevel.level[height - y][x] = finalColor;
}

// Draw the image
void draw() {
  if (currentLevel == uv) {
    uvLoop();
  } else if (currentLevel == redSphere) {
    redSphereLoop(currentLevel);
  } else if (currentLevel == normalSphere|| currentLevel == normalGround || currentLevel == antiAliasing) {
    normalLoop(currentLevel);
  } else if (currentLevel == unitRender) {
    unitLoop(currentLevel, false);
  } else if (currentLevel == gammaRender) {
    unitLoop(currentLevel, true);
  } else if (currentLevel == normalizedRender) {
    normalizedLoop(currentLevel);
  } else if (currentLevel == hemiSphereRender) {
    hemiSphereLoop(currentLevel);
  } else {
    defaultLoop(currentLevel);
  }
}

void changeRes() {
  currentLevel.drawn = currentLevel.h;
  
}

void keyPressed() {
  if (key == '+') {
    currentLevel.nSamplesPixel = 500;
    if (currentLevel == finalScene) {
      currentLevel.changeScreenSize(1200);
    }
    currentLevel.changeLevel();
  } else if (key == '-') {
    currentLevel.nSamplesPixel = 10;
    if (currentLevel == finalScene) {
      currentLevel.changeScreenSize(400);
    }
    currentLevel.changeLevel();
  } else if (key == '=') {
    currentLevel.nSamplesPixel = 100;
    if (currentLevel == finalScene) {
      currentLevel.changeScreenSize(800);
    }
    currentLevel.changeLevel();
  }
  
  if (key == 'a' || key == 'A') {
    currentLevel = uv;
    uv.changeLevel();
  } else if (key == 'b' || key == 'B') {
    currentLevel = gradient;
    gradient.changeLevel();
  } else if (key == 'c' || key == 'C') {
    currentLevel = redSphere;
    redSphere.changeLevel();
  } else if (key == 'd' || key == 'D') {
    currentLevel = normalSphere;
    normalSphere.changeLevel();
  } else if (key == 'e' || key == 'E') {
    currentLevel = normalGround;
    normalGround.changeLevel();
  } else if (key == 'f' || key == 'F') {
    currentLevel = antiAliasing;
    antiAliasing.changeLevel();
  } else if (key == 'g' || key == 'G') {
    currentLevel = unitRender;
    unitRender.changeLevel();
  } else if (key == 'h' || key == 'H') {
    currentLevel = gammaRender;
    gammaRender.changeLevel();
  } else if (key == 'i' || key == 'I') {
    currentLevel = normalizedRender;
    normalizedRender.changeLevel();
  } else if (key == 'j' || key == 'J') {
    currentLevel = hemiSphereRender;
    hemiSphereRender.changeLevel();
  } else if (key == 'k' || key == 'K') {
    currentLevel = Metal;
    Metal.changeLevel();
  } else if (key == 'l' || key == 'L') {
    currentLevel = fuzzedMetal;
    fuzzedMetal.changeLevel();
  } else if (key == 'm' || key == 'M') {
    currentLevel = Dielectric;
    Dielectric.changeLevel();
  } else if (key == 'n' || key == 'N') {
    currentLevel = refract;
    refract.changeLevel();
  } else if (key == 'o' || key == 'O') {
    currentLevel = hollowGlass;
    hollowGlass.changeLevel();
  } else if (key == 'p' || key == 'P') {
    currentLevel = blueRed;
    blueRed.changeLevel();
  } else if (key == 'q' || key == 'Q') {
    currentLevel = distantView;
    distantView.changeLevel();
  } else if (key == 'r' || key == 'R') {
    currentLevel = zoom;
    zoom.changeLevel();
  } else if (key == 's' || key == 'S') {
    currentLevel = defocusBlur;
    defocusBlur.changeLevel();
  } else if (key == 't' || key == 'T') {
    currentLevel = finalScene;
    finalScene.changeLevel();
  }
}
