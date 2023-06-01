
// The class that represents a scene
class Scene {

  // Variables for the screen
  float screenRatio = 16.0 / 9.0;
  int w = 800;
  int h = int(w / screenRatio);
  int nSamplesPixel = 10;
  int maxDepthBounce = 50;
  int printStep = 1;
  int scanLine = h;

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
  color[][] scene = new color[h][w];
  int drawn = h;

  // No constructor needed;
  Scene() {
  }

  // What to update when changing scenes
  void changeScene() {

    // Set the default title to 0%
    surface.setTitle("0%");

    // Set the size of the screen to w, h
    windowResize(w, h);

    // Restart to draw when we last stoped
    scanLine = drawn;
  }

  // What to update when changing the size of the screen
  void changeScreenSize(int _w) {

    // Update the size, recreate the saved image array and restart to draw from the top
    w = _w;
    h = int(w / screenRatio);
    scene = new color[h][w];
    drawn = h;
  }

  // Create the scene for uv
  void createUv() {

    // Change the variables to fit the scene
    screenRatio = 1;
    w = 512;
    h = int(w / screenRatio);
    nSamplesPixel = 1;
    printStep = w;
    scene = new color[h][w];
    drawn = h;
  }

  // Create the scene for the gradient
  void createGradient() {

    // Change the variables to fit the scene
    nSamplesPixel = 1;
    printStep = 100;

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);
  }

  // Create the scene for the red sphere
  void createRedSphere() {

    // Change the variables to fit the scene
    nSamplesPixel = 1;
    printStep = 100;

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matSphere = new Lambertian(new Vector3(255, 0, 0));

    // spheres
    Sphere Sphere = new Sphere(new Vector3(0, 0, -1), 0.5, matSphere);

    // Add the spheres in the world
    world.add(Sphere);
  }

  // Create the scene for the sphere with the color beeing the normal
  void createNormalSphere() {

    // Change the variables to fit the scene
    nSamplesPixel = 1;
    printStep = 10;

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matSphere = new Lambertian(new Vector3(0, 255, 0));

    // spheres
    Sphere Sphere = new Sphere(new Vector3(0, 0, -1), 0.5, matSphere);

    // Add the spheres in the world
    world.add(Sphere);
  }

  // Create the scene for the 2 spheres with the color beeing the normal
  void createNormalGround(int _nSamplesPixel) {

    // Change the variables to fit the scene (can change the number of samples for anti-aliasing)
    nSamplesPixel = _nSamplesPixel;
    printStep = 10;

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(0, 255, 0));
    Lambertian matSphere = new Lambertian(new Vector3(0, 255, 0));

    // spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere Sphere = new Sphere(new Vector3(0, 0, -1), 0.5, matSphere);

    // Add the spheres in the world
    world.add(ground);
    world.add(Sphere);
  }

  // Create the scene for the normal render
  void createUnitRender() {
    createNormalGround(10);
  }

  // Create the scene for the normal render with gamma corection
  void createGammaRender() {
    createNormalGround(10);
  }

  // Create the scene for the normalized render
  void createNormalizedRender() {
    createNormalGround(10);
  }

  // Create the scene for the hemisphere render
  void createHemisphereRender() {
    createNormalGround(10);
  }

  // Create the scene for the metal sphere
  void createMetal() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(178, 76, 76));
    Metal matLeft = new Metal(new Vector3(204, 204, 204), 0.0);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 0.0);

    // spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  // Create the scene for the fuzzy metal sphere
  void createFuzzyMetal() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(178, 76, 76));
    Metal matLeft = new Metal(new Vector3(204, 204, 204), 0.3);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 1.0);

    // spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  // Create the scene for the glass sphere
  void createDielectric() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    DielectricNoReflect matCenter = new DielectricNoReflect(1.5);
    DielectricNoReflect matLeft = new DielectricNoReflect(1.5);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 1.0);

    // spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  // Create the scene for the glass sphere with reflection
  void createReflect() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(25, 51, 128));
    Dielectric matLeft = new Dielectric(1.5);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 0.0);

    // spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(right);
  }

  // Create the scene for the hollow glass sphere
  void createHollowGlass() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matGround = new Lambertian(new Vector3(204, 204, 0));
    Lambertian matCenter = new Lambertian(new Vector3(25, 51, 128));
    Dielectric matLeft = new Dielectric(1.5);
    Metal matRight = new Metal(new Vector3(204, 153, 51), 0.0);

    // spheres
    Sphere ground = new Sphere(new Vector3(0, -100.5, -1), 100, matGround);
    Sphere center = new Sphere(new Vector3(0, 0, -1), 0.5, matCenter);
    Sphere left = new Sphere(new Vector3(-1, 0, -1), 0.5, matLeft);
    Sphere leftInside = new Sphere(new Vector3(-1, 0, -1), -0.4, matLeft);
    Sphere right = new Sphere(new Vector3(1, 0, -1), 0.5, matRight);

    // Add the spheres in the world
    world.add(ground);
    world.add(center);
    world.add(left);
    world.add(leftInside);
    world.add(right);
  }

  // Create the scene for the new camera view angle
  void createBlueRed() {

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);

    // Materials
    Lambertian matLeft = new Lambertian(new Vector3(0, 0, 255));
    Lambertian matRight = new Lambertian(new Vector3(255, 0, 0));

    // spheres
    float R = cos(PI / 4);
    Sphere left = new Sphere(new Vector3(-R, 0, -1), R, matLeft);
    Sphere right = new Sphere(new Vector3(R, 0, -1), R, matRight);

    // Add the spheres in the world
    world.add(left);
    world.add(right);
  }

  // Create the scene for the distant camera view
  void createDistantView() {
    createHollowGlass();

    // Change the camera to fit the scene
    lookFrom = new Vector3(-2, 2, 1);
    lookAt = new Vector3(0, 0, -1);

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, zoom, screenRatio, 0, distFocus);
  }

  // Create the scene for the distant zoomed camera view
  void createZoom() {
    createDistantView();

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, 20, screenRatio, 0, distFocus);
  }

  // Create the scene for the focused spheres
  void createDefocusBlur() {
    createHollowGlass();

    // Change the camera to fit the scene
    lookFrom = new Vector3(3, 3, 2);
    lookAt = new Vector3(0, 0, -1);

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, 20, screenRatio, 2, lookFrom.sub(lookAt).length());
  }

  // Create the scene for the final scene
  void createFinalScene() {

    // Change the variables to fit the scene
    screenRatio = 3.0 / 2.0;
    w = 400;
    h = int(w / screenRatio);
    nSamplesPixel = 5;
    scene = new color[h][w];
    drawn = h;

    // Change the camera to fit the scene
    lookFrom = new Vector3(13, 2, 3);
    lookAt = new Vector3(0, 0, 0);

    // Setup camera
    camera = new Camera(lookFrom, lookAt, vectorUp, 20, screenRatio, 0.1, 10);

    // Setup the ground
    Lambertian matGround = new Lambertian(new Vector3(128, 128, 128));
    Sphere ground = new Sphere(new Vector3(0, -1000, 0), 1000, matGround);
    world.add(ground);

    // Create random small spheres between -11 and 11 x and z
    for (int x = -11; x < 11; x++) {
      for (int z = -11; z < 11; z++) {

        // Get a random material and random center around the point of the grid
        float material = random(0.0, 1.0);
        Vector3 center = new Vector3(x + 0.9 * random(0.0, 1.0), 0.2, z + 0.9 * random(0.0, 1.0));

        // Restrict the placement of the small spheres
        if (center.sub(new Vector3(4, 0.2, 0)).length() > 0.9) {
          Material matS;

          // Smooth material 80% of the time
          if (material < 0.8) {

            // Get a random color
            Vector3 albedo = new Vector3(random(0, 255), random(0, 255), random(0, 255));
            matS = new Lambertian(albedo);
          }

          // Metal material 15% of the time
          else if (material < 0.95) {

            // Get a random color and fuzzyness
            Vector3 albedo = new Vector3(random(128, 255), random(128, 255), random(128, 255));
            float fuzzyness = random(0, 0.5);
            matS = new Metal(albedo, fuzzyness);
          }

          // Glass material 5% of the time
          else {
            matS = new Dielectric(1.5);
          }

          // Create the sphere at center with the matS material and add it to the world
          Sphere s = new Sphere(center, 0.2, matS);
          world.add(s);
        }
      }
    }

    // Materials of the big spheres
    Dielectric mat1 = new Dielectric(1.5);
    Lambertian mat2 = new Lambertian(new Vector3(102, 51, 25));
    Metal mat3 = new Metal(new Vector3(178, 153, 128), 0.0);

    // The big spheres
    Sphere s1 = new Sphere(new Vector3(0, 1, 0), 1.0, mat1);
    Sphere s2 = new Sphere(new Vector3(-4, 1, 0), 1.0, mat2);
    Sphere s3 = new Sphere(new Vector3(4, 1, 0), 1.0, mat3);

    // Add the big spheres in the world
    world.add(s1);
    world.add(s2);
    world.add(s3);
  }
}
