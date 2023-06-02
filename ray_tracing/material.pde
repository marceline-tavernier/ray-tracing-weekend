// Interface of Material
interface Material {
  RayInfo scatter(Ray rIn, HitRecord rec);
}

// Matte Material
class Lambertian implements Material {
  Vector3 albedo;

  Lambertian(Vector3 a) {
    albedo = a;
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    Vector3 scatterDir = rec.normal.add(randomUnitNormalized());

    if (scatterDir.nearZero()) {
      scatterDir = rec.normal;
    }

    return new RayInfo(new Ray(rec.point, scatterDir), albedo);
  }
}

// Metal Material
class Metal implements Material {
  Vector3 albedo;
  float fuzzyness;

  Metal(Vector3 a, float fuzzy) {
    albedo = a;
    fuzzyness = fuzzy < 1 ? fuzzy : 1;
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    Vector3 reflected = rIn.dir.unit().reflect(rec.normal);
    Ray scattered = new Ray(rec.point, reflected.add(randomUnit().mult(fuzzyness)));
    if (scattered.dir.dot(rec.normal) > 0) {
      return new RayInfo(scattered, albedo);
    }
    return new RayInfo();
  }
}

// Glass Material
class Dielectric implements Material {
  float iRefract;

  Dielectric(float indexRefract) {
    iRefract = indexRefract;
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    float refractRatio = rec.frontFace ? (1.0 / iRefract) : iRefract;

    Vector3 unitDir = rIn.dir.unit();
    float cosT = min(unitDir.mult(-1).dot(rec.normal), 1.0);
    float sinT = sqrt(1.0 - cosT * cosT);

    boolean noRefract = refractRatio * sinT > 1.0;
    Vector3 direction;

    if (noRefract || reflectance(cosT, refractRatio) > random(0.0, 1.0)) {
      direction = unitDir.reflect(rec.normal);
    } else {
      direction = unitDir.refract(rec.normal, refractRatio);
    }

    return new RayInfo(new Ray(rec.point, direction), new Vector3(255, 255, 255));
  }

  float reflectance(float cosine, float indexRefract) {
    float r0 = (1.0 - indexRefract) / (1.0 + indexRefract);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow((1 - cosine), 5);
  }
}

class DielectricNoReflect extends Dielectric {

  DielectricNoReflect(float indexRefract) {
    super(indexRefract);
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    float refractRatio = rec.frontFace ? (1.0 / iRefract) : iRefract;

    Vector3 unitDir = rIn.dir.unit();
    Vector3 refracted = unitDir.refract(rec.normal, refractRatio);

    return new RayInfo(new Ray(rec.point, refracted), new Vector3(255, 255, 255));
  }
}
