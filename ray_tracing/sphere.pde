// The Sphereclass
class Sphere implements Hittable {
  Vector3 center;
  float radius;
  Material mat;

  // Sphere constructors
  Sphere() {
  }
  Sphere(Vector3 cen, float r, Material m) {
    center = cen;
    radius = r;
    mat = m;
  }

  // Implementation of hit on a Sphere
  HitRecord hit(Ray r, float tMin, float tMax) {
    Vector3 oc = r.origin.sub(center);
    float a = r.dir.lengthSq();
    float halfB = oc.dot(r.dir);
    float c = oc.lengthSq() - radius * radius;

    float discriminant = halfB * halfB - a * c;
    if (discriminant < 0) {
      return new HitRecord();
    }
    float sqrtd = sqrt(discriminant);

    float root = (-halfB - sqrtd) / a;
    if (root < tMin || tMax < root) {
      root = (-halfB + sqrtd) / a;
      if (root < tMin || tMax < root) {
        return new HitRecord();
      }
    }

    float t = root;
    Vector3 p = r.at(t);
    Vector3 outwardNormal = p.sub(center).div(radius);

    return new HitRecord(p, mat, t, r, outwardNormal);
  }
}
