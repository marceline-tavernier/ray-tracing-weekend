
// Variable to define the range to search for a hit
float infinity = 9_223_372_036_854_775_807.0;

/////////////////////////////////

// The class that represent the ray
class Ray {

  // The origin and direction of the ray
  Vector3 origin;
  Vector3 dir;

  // The ray constructor
  Ray (Vector3 _origin, Vector3 direction) {
    origin = _origin;
    dir = direction;
  }

  // Return the vector of the Ray
  Vector3 at(float t) {
    return origin.add(dir.mult(t));
  }
}

// Return the sky gradient
Vector3 getGradientSky(Ray r) {

  // Create a gradient between white and blue for the sky
  Vector3 unitDir = r.dir.unit();
  float t = 0.5 * (unitDir.y + 1.0);
  return new Vector3(255, 255, 255).mult(1.0 - t).add(new Vector3(128, 178, 255).mult(t));
}

// Return the color of the ray for the scene with only a red sphere
Vector3 rayColorRedSphere(Ray r, Hittable world) {

  // Search the world for a hit
  HitRecord rec = world.hit(r, 0, infinity);

  // If the ray hit, return red
  if (rec.isHit) {
    return new Vector3(255, 0, 0);
  }

  // Return the sky gradient if the ray hit nothing
  return getGradientSky(r);
}

// Return the color of the ray for the scenes with the color beeing the normal
Vector3 rayColorNormal(Ray r, Hittable world) {

  // Search the world for a hit
  HitRecord rec = world.hit(r, 0, infinity);

  // If the ray hit, return the color as an interpretation of the normal
  if (rec.isHit) {
    return rec.normal.add(new Vector3(1, 1, 1)).mult(128);
  }

  // Return the sky gradient if the ray hit nothing
  return getGradientSky(r);
}

// Return the color of the ray for the scenes using different random bounce
Vector3 rayColorUNH(Ray r, Hittable world, int depth, float acne, char UNH) {

  // If the ray bounced more than allowed, return black
  if (depth <= 0) {
    return new Vector3(0, 0, 0);
  }

  // Search the world for a hit
  HitRecord rec = world.hit(r, acne, infinity);

  // If the ray hit, return the correct color based on what the ray bounced on
  if (rec.isHit) {

    // Use the correct random bounce algorithm
    Vector3 random = randomUnit();
    if (UNH == 'n') {
      random = randomUnitNormalized();
    } else if (UNH == 'h') {
      random = randomHemisphere(rec.normal);
    }

    // Calculate where the ray bounce and recursively call the same algorithm to calculate the actual color
    Vector3 target = rec.point.add(rec.normal).add(random);
    return rayColorUNH(new Ray(rec.point, target.sub(rec.point)), world, depth - 1, acne, UNH);
  }

  // Return the sky gradient if the ray hit nothing
  return getGradientSky(r);
}

// Return the color of the ray
Vector3 RayColor(Ray r, Hittable world, int depth) {

  // If the ray bounced more than allowed, return black
  if (depth <= 0) {
    return new Vector3(0, 0, 0);
  }

  // Search the world for a hit
  HitRecord rec = world.hit(r, 0.001, infinity);

  // If the ray hit, return the correct color based on what the ray bounced on
  if (rec.isHit) {

    // Get the ray info based on the material
    RayInfo rInfo = rec.mat.scatter(r, rec);

    // If the ray was reflected
    if (rInfo.hasRay) {

      // Recursively call the same algorithm to calculate the actual color
      Vector3 c = rInfo.col;
      Vector3 col = RayColor(rInfo.r, world, depth - 1);
      return new Vector3((c.x * col.x) / 256, (c.y * col.y) / 256, (c.z * col.z) / 256);
    }

    // Else return black (the ray was absorbed)
    return new Vector3(0, 0, 0);
  }

  // Return the sky gradient if the ray hit nothing
  return getGradientSky(r);
}

// Struct to hold the ray info
class RayInfo {

  // The ray info
  boolean hasRay;
  Ray r;
  Vector3 col;

  // The constructors
  RayInfo() {
    hasRay = false;
  }
  RayInfo(Ray _r, Vector3 _col) {
    hasRay = true;
    r = _r;
    col = _col;
  }
}
