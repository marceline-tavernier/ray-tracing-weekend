void finishLoop(Scene scene) {
  for (int j = scene.h; j > max(0, scene.drawLine - scene.drawStep); j--) {
    for (int i = 0; i < width; i++) {
      set(i, height - j, scene.scene[scene.h - j][i]);
    }
  }
}

// If the drawing is finished
void uvLoop() {

  // For each frame, start drawing at scanLine (start at the top) for printStep lines
  for (int j = height; j > 0; j--) {

    // Go over each pixel on the line
    for (int i = 0; i < width; i++) {
      float u = float(i) / (width - 1);
      float v = float(j) / (height - 1);
      setPixel(i, j, new Vector3(u * 255, v * 255, 64), 1, false);
    }
  }
  printDone();
}

Ray getRay(int i, int j, Camera camera) {
  float u = (i + random(0.0, 1.0)) / (width - 1);
  float v = (j + random(0.0, 1.0)) / (height - 1);
  return camera.getRay(u, v);
}

void endFrame(Scene scene) {
  scene.drawLine -= scene.drawStep;

  // Decrement the scanLine to draw the next printStep lines
  scene.scanLine -= scene.drawStep;
}

// If the drawing is finished
void redSphereLoop(Scene scene) {
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        setPixel(i, j, rayColorRedSphere(getRay(i, j, scene.camera), scene.world), 1, false);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    endFrame(scene);
  }
}

// If the drawing is finished
void normalLoop(Scene scene) {
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < scene.nSamplesPixel; s++) {
          pixelColor = pixelColor.add(rayColorNormal(getRay(i, j, scene.camera), scene.world));
        }
        setPixel(i, j, pixelColor, scene.nSamplesPixel, false);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    endFrame(scene);
  }
}

void UNHLoop(Scene scene, boolean gammaCorection, float acne, char UNH) {
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < scene.nSamplesPixel; s++) {
          pixelColor = pixelColor.add(rayColorUNH(getRay(i, j, scene.camera), scene.world, scene.nSamplesPixel, acne, UNH));
        }
        setPixel(i, j, pixelColor, scene.nSamplesPixel, gammaCorection);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    endFrame(scene);
  }
}

// If the drawing is finished
void defaultLoop(Scene scene) {
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < scene.nSamplesPixel; s++) {
          pixelColor = pixelColor.add(RayColor(getRay(i, j, scene.camera), scene.world, scene.nSamplesPixel));
        }
        setPixel(i, j, pixelColor, scene.nSamplesPixel, true);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    endFrame(scene);
  }
}
