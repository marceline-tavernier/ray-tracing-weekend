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

    return new RayInfo(new Ray(rec.p, scatterDir), albedo);
  }
}

// Metal Material
class Metal implements Material {
  Vector3 albedo;
  float fuzz;

  Metal(Vector3 a, float f) {
    albedo = a;
    fuzz = f < 1 ? f : 1;
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    Vector3 reflected = rIn.dir.unit().reflect(rec.normal);
    Ray scattered = new Ray(rec.p, reflected.add(randomUnit().mult(fuzz)));
    if (scattered.dir.dot(rec.normal) > 0) {
      return new RayInfo(scattered, albedo);
    }
    return new RayInfo();
  }
}

// Glass Material
class Dielectric implements Material {
  float ir;

  Dielectric(float indexR) {
    ir = indexR;
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    float rRatio = rec.frontFace ? (1.0 / ir) : ir;

    Vector3 unitDir = rIn.dir.unit();
    float cosT = min(unitDir.mult(-1).dot(rec.normal), 1.0);
    float sinT = sqrt(1.0 - cosT * cosT);
    
    boolean cannotR = rRatio * sinT > 1.0;
    Vector3 direction;
    
    if (cannotR || reflectance(cosT, rRatio) > random(0.0, 1.0)) {
      direction = unitDir.reflect(rec.normal);
    } else {
      direction = unitDir.refract(rec.normal, rRatio);
    }

    return new RayInfo(new Ray(rec.p, direction), new Vector3(255, 255, 255));
  }
  
  float reflectance(float cosine, float indexR) {
    float r0 = (1.0 - indexR) / (1.0 + indexR);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow((1 - cosine), 5);
  }
}

class DielectricNoReflect implements Material {
  float ir;

  DielectricNoReflect(float indexR) {
    ir = indexR;
  }

  RayInfo scatter(Ray rIn, HitRecord rec) {
    float rRatio = rec.frontFace ? (1.0 / ir) : ir;

    Vector3 unitDir = rIn.dir.unit();
    Vector3 refracted = unitDir.refract(rec.normal, rRatio);

    return new RayInfo(new Ray(rec.p, refracted), new Vector3(255, 255, 255));
  }
  
  float reflectance(float cosine, float indexR) {
    float r0 = (1.0 - indexR) / (1.0 + indexR);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow((1 - cosine), 5);
  }
}
