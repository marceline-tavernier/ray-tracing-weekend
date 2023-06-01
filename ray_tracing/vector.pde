
// The Vector3 class
class Vector3 {

  // Each componant of the vector
  float x;
  float y;
  float z;

  // The constructor
  Vector3(float _x, float _y, float _z) {
    x = _x;
    y = _y;
    z = _z;
  }

  // Add 2 vector
  Vector3 add(Vector3 v) {

    // u + v
    return new Vector3(x + v.x, y + v.y, z + v.z);
  }

  // Substract v from u
  Vector3 sub(Vector3 v) {

    // u - v
    return new Vector3(x - v.x, y - v.y, z - v.z);
  }

  // Multiply u by v
  Vector3 mult(Vector3 v) {

    // u * v
    return new Vector3(x * v.x, y * v.y, z * v.z);
  }

  // Multiply v by f
  Vector3 mult(float f) {

    // v * f
    return new Vector3(x * f, y * f, z * f);
  }

  // Divide v by f
  Vector3 div(float f) {

    // v / f
    return this.mult(1 / f);
  }

  // Dot product of u and v
  float dot(Vector3 v) {

    // u . v
    return x * v.x + y * v.y + z * v.z;
  }

  // Cross product of u and v
  Vector3 cross(Vector3 v) {

    //u x v
    return new Vector3(y * v.z - z * v.y, z * v.x - x * v.z, x * v.y - y * v.x);
  }

  // Return the unit vector of v
  Vector3 unit() {

    // v / length of v
    return this.div(this.length());
  }

  // Return the length of v
  float length() {

    // square root of length squared
    return sqrt(this.lengthSq());
  }

  // Return the length squared of v
  float lengthSq() {

    // Euclidien distance without the square root
    return x * x + y * y + z * z;
  }

  // Return the reflected vector around the normal
  Vector3 reflect(Vector3 normal) {

    // v - normal * ( 2 * v . normal)
    return this.sub(normal.mult((2 * this.dot(normal))));
  }

  // Transform a vector to a color
  color toColor() {
    return color(x, y, z);
  }

  // Return the refracted vector around the normal with the refractive indices
  Vector3 refract(Vector3 normal, float refracIndices) {

    // Calculate the cos of angle and perendicular and parallel of refracted Ray
    float cosO = min(this.mult(-1).dot(normal), 1.0);
    Vector3 rPerp = this.add(normal.mult(cosO)).mult(refracIndices);
    Vector3 rPara = normal.mult(-sqrt(abs(1.0 - rPerp.lengthSq())));
    return rPerp.add(rPara);
  }

  // Return if a vector is near zero
  boolean nearZero() {
    float e = 1e-8;
    return (x < e) && (y < e) && (z < e);
  }
}

// Return a random unit vector
Vector3 randomUnit() {
  while (true) {

    // Get random vector of max 1 length for each x, y, and z, if lenght squared more than 1, retry
    Vector3 v = new Vector3(random(-1.0, 1.0), random(-1.0, 1.0), random(-1.0, 1.0));
    if (v.lengthSq() >= 1) {
      continue;
    }
    return v;
  }
}

// Return a random unit vector normalized
Vector3 randomUnitNormalized() {
  while (true) {

    // Get random vector of max 1 length for each x, y, and z, normalize it, if lenght squared more than 1, retry
    Vector3 v = new Vector3(random(-1.0, 1.0), random(-1.0, 1.0), random(-1.0, 1.0)).unit();
    if (v.lengthSq() >= 1) {
      continue;
    }
    return v;
  }
}

// Return a random unit vector in a hemiSphere
Vector3 randomHemisphere(Vector3 normal) {

  // Get a random unit vector and if in bottom half of Sphere, inverse it
  Vector3 v = randomUnit();
  if (v.dot(normal) > 0.0) {
    return v;
  } else {
    return v.mult(-1);
  }
}

// Return a random vector in a disk
Vector3 randomDisk() {
  while (true) {

    // Get random vector of max 1 length for each x and y, so that it is on the disk x, y, if lenght squared more than 1, retry
    Vector3 v = new Vector3(random(-1, 1), random(-1, 1), 0);
    if (v.lengthSq() >= 1) {
      continue;
    } else {
      return v;
    }
  }
}
