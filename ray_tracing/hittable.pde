
// The interface of hittables objects
interface Hittable {
  HitRecord hit(Ray r, float tMin, float tMax);
}

// The class of hittables list
class HittableList implements Hittable {

  // The list of hittables object
  ArrayList<Hittable> objects = new ArrayList<Hittable>();

  // The hittables list constructor
  HittableList() {
  }

  // Add a hittable to the existing list
  void add(Hittable object) {
    objects.add(object);
  }

  // The implementation of hit for a list of hittables
  HitRecord hit(Ray r, float tMin, float tMax) {

    // Create the hit record and set the closest hit to tMax
    HitRecord rec = new HitRecord();
    float closest = tMax;

    // For all hittables in the list
    for (Hittable object : objects) {

      // Check if the ray hit it
      HitRecord tempRec = object.hit(r, tMin, closest);

      // If it does, set this object to be the closest hit object
      if (tempRec.isHit) {
        closest = tempRec.t;
        rec = tempRec;
      }
    }

    // Return the closest hit object
    return rec;
  }
}

// Struct to hold the hit record
class HitRecord {

  // All the important info to record a hit
  boolean isHit;
  Vector3 point;
  Vector3 normal;
  Material mat;
  float t;
  boolean frontFace;

  // Hit record constructors
  HitRecord() {
    isHit = false;
  }
  HitRecord(Vector3 p, Material m, float _t, Ray r, Vector3 outwardNormal) {
    isHit = true;
    point = p;
    mat = m;
    t = _t;
    setFaceNormal(r, outwardNormal);
  }

  // Determine if we hit the face from outside or inside
  void setFaceNormal(Ray r, Vector3 outwardNormal) {
    frontFace = r.dir.dot(outwardNormal) < 0;
    normal = frontFace ? outwardNormal : outwardNormal.mult(-1);
  }
}
