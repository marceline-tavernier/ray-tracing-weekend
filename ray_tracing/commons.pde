float infinity = 9_223_372_036_854_775_807.0;

/*HittableList randomScene() {
  HittableList world = new HittableList();
  
  Lambertian matGround = new Lambertian(color(128, 128, 128));
  Sphereground = new Sphere(new PVector(0, -1000, 0), 1000, matGround);
  world.add(ground);
  
  for (int a = -8; a < 8; a++) {
    for (int b = -8; b < 8; b++) {
      float mat = random(0.0, 1.0);
      PVector center = new PVector(a + 0.9 * random(0.0, 1.0), 0.2, b + 0.9 * random(0.0, 1.0));
      
      if (PVector.sub(center, new PVector(4, 0.2, 0)).mag() > 0.9) {
        Material matS;
        
        if (mat < 0.8) {
          color albedo = color(random(0, 255), random(0,255), random(0, 255));
          matS = new Lambertian(albedo);
        } else if (mat < 0.95) {
          color albedo = color(random(128, 255), random(128,255), random(128, 255));
          float fuzz = random(0, 0.5);
          matS = new Metal(albedo, fuzz);
        } else {
          matS = new Dielectric(1.5);
        }
        
        Spheres = new Sphere(center, 0.2, matS);
        world.add(s);
      }
    }
  }
  
  
  Dielectric mat1 = new Dielectric(1.5);
  Spheres1 = new Sphere(new PVector(0, 1, 0), 1.0, mat1);
  world.add(s1);
  
  Lambertian mat2 = new Lambertian(color(102, 51, 25));
  Spheres2 = new Sphere(new PVector(-4, 1, 0), 1.0, mat2);
  world.add(s2);

  Metal mat3 = new Metal(color(178, 153, 128), 0.0);
  Sphere s3 = new Sphere(new PVector(4, 1, 0), 1.0, mat3);
  world.add(s3);
  
  return world;
}*/
