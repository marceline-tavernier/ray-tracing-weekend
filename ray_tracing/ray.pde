// The class that represent the Ray
class Ray {
  Vector3 origin;
  Vector3 dir;

  // Ray constructor
  Ray (Vector3 _origin, Vector3 direction) {
    origin = _origin;
    dir = direction;
  }

  // Return the vector of the Ray
  Vector3 at(float t) {
    return origin.add(dir.mult(t));
  }
}

Vector3 getGradientSky(Ray r) {
  Vector3 unitDir = r.dir.unit();
  float t = 0.5 * (unitDir.y + 1.0);
  return new Vector3(255, 255, 255).mult(1.0 - t).add(new Vector3(128, 178, 255).mult(t));
}

Vector3 rayColorRedSphere(Ray r, Hittable world) {
  HitRecord rec = world.hit(r, 0.001, infinity);

  if (rec.isHit) {
    return new Vector3(255, 0, 0);
  }
  
  return getGradientSky(r);
}

Vector3 rayColorNormal(Ray r, Hittable world) {
  HitRecord rec = world.hit(r, 0.001, infinity);
  
  if (rec.isHit) {
    return rec.normal.add(new Vector3(1, 1, 1)).mult(128);
  }
  
  return getGradientSky(r);
}

Vector3 rayColorUNH(Ray r, Hittable world, int depth, char UnitNormalHemi) {
  if (depth <= 0) {
    return new Vector3(0, 0, 0);
  }

  HitRecord rec = world.hit(r, 0.001, infinity);

  if (rec.isHit) {
    Vector3 random = randomUnit();
    if (UnitNormalHemi == 'n') {
      random = randomUnitNormalized();
    } else if (UnitNormalHemi == 'h') {
      random = randomHemisphere(rec.normal);
    }
    Vector3 target = rec.p.add(rec.normal).add(random);
    return rayColorUNH(new Ray(rec.p, target.sub(rec.p)), world, depth - 1, UnitNormalHemi);
  }

  return getGradientSky(r);
}

// Return the color of the Ray (background or color of the Sphere)
Vector3 RayColor(Ray r, Hittable world, int depth) {
  if (depth <= 0) {
    return new Vector3(0, 0, 0);
  }

  HitRecord rec = world.hit(r, 0.001, infinity);

  if (rec.isHit) {

    RayInfo rc = rec.mat.scatter(r, rec);
    if (rc.hasRay) {
      Vector3 c = rc.c;
      Vector3 col = RayColor(rc.r, world, depth - 1);
      return new Vector3((c.x * col.x) / 256, (c.y * col.y) / 256, (c.z * col.z) / 256);
    }
    return new Vector3(0, 0, 0);
  }

  return getGradientSky(r);
}

// Struct to hold the Ray info
class RayInfo {
  boolean hasRay;
  Ray r;
  Vector3 c;

  RayInfo() {
    hasRay = false;
  }
  RayInfo(Ray _r, Vector3 col) {
    hasRay = true;
    r = _r;
    c = col;
  }
}
