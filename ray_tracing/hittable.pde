// The interface of Hittables objects
interface Hittable {
  HitRecord hit(Ray r, float tMin, float tMax);
}

// The class of Hittables list
class HittableList implements Hittable {
  ArrayList<Hittable> objects = new ArrayList<Hittable>();

  // The Hittables list constructor
  HittableList() {
  }

  // Add a list of Hittables to the existing list
  void add(Hittable object) {
    objects.add(object);
  }

  // The implementation of hit for a list of Hittables
  HitRecord hit(Ray r, float tMin, float tMax) {
    HitRecord rec = new HitRecord();
    float closest = tMax;

    for (Hittable object : objects) {
      HitRecord tempRec = object.hit(r, tMin, closest);
      if (tempRec.isHit) {
        closest = tempRec.t;
        rec = tempRec;
      }
    }

    return rec;
  }
}

// Struct to hold the hit record
class HitRecord {
  boolean isHit;
  Vector3 point;
  Vector3 normal;
  Material mat;
  float t;
  boolean frontFace;

  // Hit record constructor
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
