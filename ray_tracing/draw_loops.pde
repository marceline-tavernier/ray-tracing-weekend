
// The loop for when the generation is finished
void finishLoop(Scene scene) {

  // For all the pixel of the screen, draw the image from the scene memory
  for (int j = scene.h; j > max(0, scene.drawLine - scene.drawStep); j--) {
    for (int i = 0; i < width; i++) {
      set(i, height - j, scene.scene[scene.h - j][i]);
    }
  }
}

// The loop for the first scene
void uvLoop() {

  // For each frame, start drawing at scanLine (start at the top) for printStep lines
  for (int j = height; j > 0; j--) {

    // Go over each pixel on the line
    for (int i = 0; i < width; i++) {
      float u = float(i) / (width - 1);
      float v = float(j) / (height - 1);

      // Set the pixel color based on the coordinate
      setPixel(i, j, new Vector3(u * 255, v * 255, 64), 1, false);
    }
  }

  // The drawing is done
  printDone();
}

// Get the ray from the camera at i, j
Ray getRay(int i, int j, Camera camera) {
  float u = (i + random(0.0, 1.0)) / (width - 1);
  float v = (j + random(0.0, 1.0)) / (height - 1);
  return camera.getRay(u, v);
}

// Update the variables when a line is finished drawing
void endLine(Scene scene) {

  // Change the line to start drawing from (print what's in the scene memory for what's above)
  scene.drawLine -= scene.drawStep;

  // Decrement the scanLine to draw the next printStep lines
  scene.scanLine -= scene.drawStep;
}

// The loop for the red sphere scene
void redSphereLoop(Scene scene) {

  // If the drawing is finished
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {

        // Get the color of what the ray as hit from the rayColorRedSphere function
        setPixel(i, j, rayColorRedSphere(getRay(i, j, scene.camera), scene.world), 1, false);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    // Update the variables at the end of printStep lines
    endLine(scene);
  }
}

// If the drawing is finished
void normalLoop(Scene scene) {

  // If the drawing is finished
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {

        // Default color is black
        Vector3 pixelColor = new Vector3(0, 0, 0);

        // For nSamplesPixel, shoot a ray from this pixel
        for (int s = 0; s < scene.nSamplesPixel; s++) {

          // Get the color of what the ray as hit from the rayColorNormal function
          pixelColor = pixelColor.add(rayColorNormal(getRay(i, j, scene.camera), scene.world));
        }

        // Set the pixel color accordingly
        setPixel(i, j, pixelColor, scene.nSamplesPixel, false);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    // Update the variables at the end of printStep lines
    endLine(scene);
  }
}

void UNHLoop(Scene scene, boolean gammaCorection, float acne, char UNH) {

  // If the drawing is finished
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {

        // Default color is black
        Vector3 pixelColor = new Vector3(0, 0, 0);

        // For nSamplesPixel, shoot a ray from this pixel
        for (int s = 0; s < scene.nSamplesPixel; s++) {

          // Get the color of what the ray as hit from the rayColorUNH function
          pixelColor = pixelColor.add(rayColorUNH(getRay(i, j, scene.camera), scene.world, scene.nSamplesPixel, acne, UNH));
        }

        // Set the pixel color accordingly
        setPixel(i, j, pixelColor, scene.nSamplesPixel, gammaCorection);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    // Update the variables at the end of printStep lines
    endLine(scene);
  }
}

// If the drawing is finished
void defaultLoop(Scene scene) {

  // If the drawing is finished
  finishLoop(scene);
  if (scene.scanLine < 0) {

    // Print the done message and stop the loop
    printDone();
  } else {

    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = scene.scanLine; j > max(0, scene.scanLine - scene.drawStep); j--) {

      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {

        // Default color is black
        Vector3 pixelColor = new Vector3(0, 0, 0);

        // For nSamplesPixel, shoot a ray from this pixel
        for (int s = 0; s < scene.nSamplesPixel; s++) {

          // Get the color of what the ray as hit from the RayColor function
          pixelColor = pixelColor.add(RayColor(getRay(i, j, scene.camera), scene.world, scene.nSamplesPixel));
        }

        // Set the pixel color accordingly
        setPixel(i, j, pixelColor, scene.nSamplesPixel, true);
      }

      // Print the progress
      printProgress(j - 1, height);
    }

    // Update the variables at the end of printStep lines
    endLine(scene);
  }
}
