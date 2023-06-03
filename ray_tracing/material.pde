
// Interface of Material
interface Material {
  RayInfo scatter(Ray rIn, HitRecord rec);
}

// Matte Material
class Lambertian implements Material {

  // Save the color
  Vector3 albedo;

  // The constructor
  Lambertian(Vector3 a) {
    albedo = a;
  }

  // Get the info of the ray that bounced of this material
  RayInfo scatter(Ray rIn, HitRecord rec) {

    // Get the scatter direction
    Vector3 scatterDir = rec.normal.add(randomUnitNormalized());

    // If the scatter direction is almost 0, set it to the normal
    if (scatterDir.nearZero()) {
      scatterDir = rec.normal;
    }

    // Return the ray info
    return new RayInfo(new Ray(rec.point, scatterDir), albedo);
  }
}

// Metal Material
class Metal implements Material {

  // The color and fuzzyness of the metal
  Vector3 albedo;
  float fuzzyness;

  // The constructor
  Metal(Vector3 a, float fuzzy) {
    albedo = a;
    fuzzyness = fuzzy < 1 ? fuzzy : 1;
  }

  // Get the info of the ray that bounced of this material
  RayInfo scatter(Ray rIn, HitRecord rec) {

    // Get the reflected ray
    Vector3 reflected = rIn.dir.unit().reflect(rec.normal);

    // Get the scatter direction
    Ray scattered = new Ray(rec.point, reflected.add(randomUnit().mult(fuzzyness)));

    // If the scattered ray is in the same direction as the normal, return the ray info
    if (scattered.dir.dot(rec.normal) > 0) {
      return new RayInfo(scattered, albedo);
    }

    // The ray was absorbed
    return new RayInfo();
  }
}

// Glass Material
class Dielectric implements Material {

  // The index of refraction
  float iRefract;

  // The constructor
  Dielectric(float indexRefract) {
    iRefract = indexRefract;
  }

  // Get the info of the ray that bounced of this material
  RayInfo scatter(Ray rIn, HitRecord rec) {

    // Get the ratio of the index of refraction
    float refractRatio = rec.frontFace ? (1.0 / iRefract) : iRefract;

    // Useful variables
    Vector3 unitDir = rIn.dir.unit();
    float cosT = min(unitDir.mult(-1).dot(rec.normal), 1.0);
    float sinT = sqrt(1.0 - cosT * cosT);

    // Check if the ray is refracted
    boolean noRefract = refractRatio * sinT > 1.0;
    Vector3 direction;

    // If the ray is not refracted or is not reflected
    if (noRefract || reflectance(cosT, refractRatio) > random(0.0, 1.0)) {

      // The ray is reflected
      direction = unitDir.reflect(rec.normal);
    } else {

      // The ray is refracted
      direction = unitDir.refract(rec.normal, refractRatio);
    }

    // Return the ray info
    return new RayInfo(new Ray(rec.point, direction), new Vector3(255, 255, 255));
  }

  // Calculate the reflectance of a surface
  float reflectance(float cosine, float indexRefract) {
    float r0 = (1.0 - indexRefract) / (1.0 + indexRefract);
    r0 = r0 * r0;
    return r0 + (1.0 - r0) * pow((1 - cosine), 5);
  }
}

// Like the glass material but with no reflection
class DielectricNoReflect extends Dielectric {

  // The constructor
  DielectricNoReflect(float indexRefract) {
    super(indexRefract);
  }

  // Get the info of the ray that bounced of this material
  RayInfo scatter(Ray rIn, HitRecord rec) {

    // Get the ratio of the index of refraction
    float refractRatio = rec.frontFace ? (1.0 / iRefract) : iRefract;

    // The direction of the incomming ray as a unit vector
    Vector3 unitDir = rIn.dir.unit();

    // The ray is refracted as this material does not reflect rays
    Vector3 refracted = unitDir.refract(rec.normal, refractRatio);

    // Return the ray info
    return new RayInfo(new Ray(rec.point, refracted), new Vector3(255, 255, 255));
  }
}
