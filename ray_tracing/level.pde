// The class that represents a level
class Level {

  // Variables for the screen
  float screenRatio = 16.0 / 9.0;
  int w;
  int h;
  int nSamplesPixel;
  int maxDepthBounce = 50;
  int printStep;
  int scanLine;

  // Variables for the camera
  Vector3 lookFrom = new Vector3(0, 0, 0);
  Vector3 lookAt = new Vector3(0, 0, -1);
  Vector3 vectorUp = new Vector3(0, 1, 0);
  float distFocus = lookFrom.sub(lookAt).length();
  float zoom = 90;

  Camera camera;

  // Variables for the world
  HittableList world = new HittableList();

  // Others
  boolean normalLevel;
  color[][] level;
  int drawn;

  Level(int _w, int _nSamplesPixel, int _printStep) {

    w = _w;
    h = int(w / screenRatio);
    scanLine = h;
    nSamplesPixel = _nSamplesPixel;
    printStep = _printStep;

    // Others
    level = new color[h][w];
    drawn = h;
  }

  void changeLevel() {
    surface.setTitle("0%");
    // Set the size of the screen to w, h
    windowResize(w, h);
    //background(0);
    scanLine = drawn;
  }
  
  void changeScreenSize(int _w) {
    w = _w;
    h = int(w / screenRatio);
    level = new color[h][w];
    drawn = h;
  }
  
  void createUv() {
    screenRatio = 1;
    h = int(w / screenRatio);
    level = new color[h][w];
    drawn = h;
  }

  void createGradient() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);
  }

  void createRedSphere() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matSphere = new Lambertian(new Vector3(255, 0, 0));

    // Spheres
    Sphere Sphere = new Sphere(new Vector3(0, 0, -1), 0.5, matSphere);

    // Add the Spheres in the world
    world.add(Sphere);
  }

  void createNormalSphere() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matSphere = new Lambertian(new Vector3(0, 255, 0));

    // Spheres
    Sphere Sphere = new Sphere(new Vector3(0, 0, -1), 0.5, matSphere);

    // Add the Spheres in the world
    world.add(Sphere);
  }

  void createNormalGround() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(0, 255, 0));
    Lambertian matSphere = new Lambertian(new Vector3(0, 255, 0));

    // Spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere Sphere = new Sphere(new Vector3(0, 0, -1), 0.5, matSphere);

    // Add the Spheres in the world
    world.add(ground);
    world.add(Sphere);
  }
  
  void createUnitRender() {
    createNormalGround();
  }
  
  void createGammaRender() {
    createNormalGround();
  }
  
  void createNormalizedRender() {
    createNormalGround();
  }
  
  void createHemiSphereRender() {
    createNormalGround();
  }

  void createMetal() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(178, 76, 76));
    Metal matLeft = new Metal(new Vector3(204, 204, 204), 0.0);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 0.0);

    // Spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the Spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  void createFuzzedMetal() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(178, 76, 76));
    Metal matLeft = new Metal(new Vector3(204, 204, 204), 0.3);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 1.0);

    // Spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the Spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  void createDielectric() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    DielectricNoReflect matCenter = new DielectricNoReflect(1.5);
    DielectricNoReflect matLeft = new DielectricNoReflect(1.5);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 1.0);

    // Spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the Spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  void createRefract() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(25, 51, 128));
    Dielectric matLeft = new Dielectric(1.5);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 0.0);

    // Spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the Spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  void createHollowGlass() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(25, 51, 128));
    Dielectric matLeft = new Dielectric(1.5);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 0.0);

    // Spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere leftInside = new Sphere(new Vector3(-1, 0, -1), -0.4, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the Spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(leftInside);
    world.add(right);
  }

  void createBlueRed() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matLeft = new Lambertian(new Vector3(0, 0, 255));
    Lambertian matRight = new Lambertian(new Vector3(255, 0, 0));

    // Spheres
    float R = cos(PI / 4);
    Sphere left = new Sphere(new Vector3(-R, 0, -1), R, matLeft);
    Sphere right = new Sphere(new Vector3(R, 0, -1), R, matRight);

    // Add the Spheres in the world
    world.add(left);
    world.add(right);
  }

  void createDistantView() {
    createHollowGlass();

    lookFrom = new Vector3(-2, 2, 1);
    lookAt = new Vector3(0, 0, -1);

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);
  }

  void createZoom() {
    createDistantView();

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, 20, screenRatio, 0, distFocus);
  }

  void createDefocusBlur() {
    createHollowGlass();

    lookFrom = new Vector3(3, 3, 2);
    lookAt = new Vector3(0, 0, -1);

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, 20, screenRatio, 2, lookFrom.sub(lookAt).length());
  }

  void createFinalScene() {
    screenRatio = 3.0 / 2.0;
    h = int(w / screenRatio);
    level = new color[h][w];
    drawn = h;
    
    lookFrom = new Vector3(13, 2, 3);
    lookAt = new Vector3(0, 0, 0);

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, 20, screenRatio, 0.1, 10);

    Lambertian matGround = new Lambertian(new Vector3(128, 128, 128));
    Sphere ground = new Sphere(new Vector3(0, -1000, 0), 1000, matGround);
    world.add(ground);

    for (int a = -11; a < 11; a++) {
      for (int b = -11; b < 11; b++) {
        float mat = random(0.0, 1.0);
        Vector3 center = new Vector3(a + 0.9 * random(0.0, 1.0), 0.2, b + 0.9 * random(0.0, 1.0));

        if (center.sub(new Vector3(4, 0.2, 0)).length() > 0.9) {
          Material matS;

          if (mat < 0.8) {
            Vector3 albedo = new Vector3(random(0, 255), random(0, 255), random(0, 255));
            matS = new Lambertian(albedo);
          } else if (mat < 0.95) {
            Vector3 albedo = new Vector3(random(128, 255), random(128, 255), random(128, 255));
            float fuzz = random(0, 0.5);
            matS = new Metal(albedo, fuzz);
          } else {
            matS = new Dielectric(1.5);
          }

          Sphere s = new Sphere(center, 0.2, matS);
          world.add(s);
        }
      }
    }

    Dielectric mat1 = new Dielectric(1.5);
    Sphere s1 = new Sphere(new Vector3(0, 1, 0), 1.0, mat1);
    world.add(s1);

    Lambertian mat2 = new Lambertian(new Vector3(102, 51, 25));
    Sphere s2 = new Sphere(new Vector3(-4, 1, 0), 1.0, mat2);
    world.add(s2);

    Metal mat3 = new Metal(new Vector3(178, 153, 128), 0.0);
    Sphere s3 = new Sphere(new Vector3(4, 1, 0), 1.0, mat3);
    world.add(s3);
  }
}
