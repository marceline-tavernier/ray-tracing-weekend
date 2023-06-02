
// The sphere class
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

    // Calculate if the ray hit the sphere
    Vector3 oc = r.origin.sub(center);
    float a = r.dir.lengthSq();
    float halfB = oc.dot(r.dir);
    float c = oc.lengthSq() - radius * radius;
    float discriminant = halfB * halfB - a * c;

    // The ray didn't hit the sphere
    if (discriminant < 0) {
      return new HitRecord();
    }
    float sqrtD = sqrt(discriminant);

    // Calculate if the hit is between the range tMin and tMax
    float root = (-halfB - sqrtD) / a;
    if (root < tMin || tMax < root) {
      root = (-halfB + sqrtD) / a;
      if (root < tMin || tMax < root) {

        // The hit as outside the range
        return new HitRecord();
      }
    }

    // Create the hit record of where the point hit
    float t = root;
    Vector3 point = r.at(t);
    Vector3 outwardNormal = point.sub(center).div(radius);

    return new HitRecord(point, mat, t, r, outwardNormal);
  }
}
