
// The camera class
class Camera {
  Vector3 origin;
  Vector3 lowerLeftCorner;
  Vector3 horizontal;
  Vector3 vertical;
  Vector3 u, v, w;
  float lensRadius;

  Camera(Vector3 lookFrom, Vector3 lookAt, Vector3 vecUp, float verticalFov, float screenRatio, float aperture, float distFocus) {
    float theta = radians(verticalFov);
    float h = tan(theta / 2);
    float viewportHeight = 2.0 * h;
    float viewportWidth = screenRatio * viewportHeight;

    // The z, x and y of the camera plane
    w = (lookFrom.sub(lookAt)).unit();
    u = (vecUp.cross(w)).unit();
    v = w.cross(u);

    origin = lookFrom;
    horizontal = u.mult(viewportWidth * distFocus);
    vertical = v.mult(viewportHeight * distFocus);
    Vector3 _halfH = horizontal.div(2);
    Vector3 _halfV = vertical.div(2);
    Vector3 _origHV = origin.sub(_halfH).sub(_halfV);
    lowerLeftCorner = _origHV.sub(w.mult(distFocus));

    lensRadius = aperture / 2;
  }

  Ray getRay(float s, float t) {
    Vector3 randomDisk = randomDisk().mult(lensRadius);
    Vector3 offset = u.mult(randomDisk.x).add(v.mult(randomDisk.y));

    Vector3 _sH = horizontal.mult(s);
    Vector3 _tV = vertical.mult(t);
    Vector3 dir = lowerLeftCorner.add(_sH).add(_tV).sub(origin.add(offset));
    return new Ray(origin.add(offset), dir);
  }
}
