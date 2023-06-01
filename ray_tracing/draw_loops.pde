void finishLoop(Level level) {
  for (int j = level.h; j > max(0, level.drawn - level.printStep); j--) {
    for (int i = 0; i < width; i++) {
      //println(level.drawn);
      set(i, height - j, level.level[level.h - j][i]);
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
      setPixel(i, j, new Vector3(u * 255, v * 255, 0), 1, false);
    }
  }
}

// If the drawing is finished
void redSphereLoop(Level level) {
  finishLoop(level);
  if (level.scanLine < 0) {
    
    // Print the done message and stop the loop
    printDone();
  } else {
    
    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = level.scanLine; j > max(0, level.scanLine - level.printStep); j--) {
      
      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        float u = (i + random(0.0, 1.0)) / (width - 1);
        float v = (j + random(0.0, 1.0)) / (height - 1);
        Ray r = level.camera.getRay(u, v);        
        setPixel(i, j, rayColorRedSphere(r, level.world), 1, false);
      }
      
      // Print the progress
      printProgress(j - 1, height);
    }
    
    level.drawn -= level.printStep;
    
    // Decrement the scanLine to draw the next printStep lines
    level.scanLine -= level.printStep;
  }
}

// If the drawing is finished
void normalLoop(Level level) {
  finishLoop(level);
  if (level.scanLine < 0) {
    
    // Print the done message and stop the loop
    printDone();
  } else {
    
    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = level.scanLine; j > max(0, level.scanLine - level.printStep); j--) {
      
      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < level.nSamplesPixel; s++) {
          float u = (i + random(0.0, 1.0)) / (width - 1);
          float v = (j + random(0.0, 1.0)) / (height - 1);
          Ray r = level.camera.getRay(u, v);     
          pixelColor = pixelColor.add(rayColorNormal(r, level.world));
        }
        setPixel(i, j, pixelColor, level.nSamplesPixel, false);
      }
      
      // Print the progress
      printProgress(j - 1, height);
    }
    
    level.drawn -= level.printStep;
    
    // Decrement the scanLine to draw the next printStep lines
    level.scanLine -= level.printStep;
  }
}

void unitLoop(Level level, boolean gammaCorection) {
  finishLoop(level);
  if (level.scanLine < 0) {
    
    // Print the done message and stop the loop
    printDone();
  } else {
    
    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = level.scanLine; j > max(0, level.scanLine - level.printStep); j--) {
      
      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < level.nSamplesPixel; s++) {
          float u = (i + random(0.0, 1.0)) / (width - 1);
          float v = (j + random(0.0, 1.0)) / (height - 1);
          Ray r = level.camera.getRay(u, v);
          pixelColor = pixelColor.add(rayColorUNH(r, level.world, level.nSamplesPixel, 'u'));
        }
        setPixel(i, j, pixelColor, level.nSamplesPixel, gammaCorection);
      }
      
      // Print the progress
      printProgress(j - 1, height);
    }
    
    level.drawn -= level.printStep;
    
    // Decrement the scanLine to draw the next printStep lines
    level.scanLine -= level.printStep;
  }
}

void normalizedLoop(Level level) {
  finishLoop(level);
  if (level.scanLine < 0) {
    
    // Print the done message and stop the loop
    printDone();
  } else {
    
    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = level.scanLine; j > max(0, level.scanLine - level.printStep); j--) {
      
      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < level.nSamplesPixel; s++) {
          float u = (i + random(0.0, 1.0)) / (width - 1);
          float v = (j + random(0.0, 1.0)) / (height - 1);
          Ray r = level.camera.getRay(u, v);
          pixelColor = pixelColor.add(rayColorUNH(r, level.world, level.nSamplesPixel, 'n'));
        }
        setPixel(i, j, pixelColor, level.nSamplesPixel, true);
      }
      
      // Print the progress
      printProgress(j - 1, height);
    }
    
    level.drawn -= level.printStep;
    
    // Decrement the scanLine to draw the next printStep lines
    level.scanLine -= level.printStep;
  }
}

void hemiSphereLoop(Level level) {
  finishLoop(level);
  if (level.scanLine < 0) {
    
    // Print the done message and stop the loop
    printDone();
  } else {
    
    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = level.scanLine; j > max(0, level.scanLine - level.printStep); j--) {
      
      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < level.nSamplesPixel; s++) {
          float u = (i + random(0.0, 1.0)) / (width - 1);
          float v = (j + random(0.0, 1.0)) / (height - 1);
          Ray r = level.camera.getRay(u, v);
          pixelColor = pixelColor.add(rayColorUNH(r, level.world, level.nSamplesPixel, 'h'));
        }
        setPixel(i, j, pixelColor, level.nSamplesPixel, true);
      }
      
      // Print the progress
      printProgress(j - 1, height);
    }
    
    level.drawn -= level.printStep;
    
    // Decrement the scanLine to draw the next printStep lines
    level.scanLine -= level.printStep;
  }
}

// If the drawing is finished
void defaultLoop(Level level) {
  finishLoop(level);
  if (level.scanLine < 0) {
    
    // Print the done message and stop the loop
    printDone();
  } else {
    
    // For each frame, start drawing at scanLine (start at the top) for printStep lines
    for (int j = level.scanLine; j > max(0, level.scanLine - level.printStep); j--) {
      
      // Go over each pixel on the line
      for (int i = 0; i < width; i++) {
        Vector3 pixelColor = new Vector3(0, 0, 0);
        for (int s = 0; s < level.nSamplesPixel; s++) {
          float u = (i + random(0.0, 1.0)) / (width - 1);
          float v = (j + random(0.0, 1.0)) / (height - 1);
          Ray r = level.camera.getRay(u, v);
          pixelColor = pixelColor.add(RayColor(r, level.world, level.nSamplesPixel));
        }
        setPixel(i, j, pixelColor, level.nSamplesPixel, true);
      }
      
      // Print the progress
      printProgress(j - 1, height);
    }
    
    level.drawn -= level.printStep;
    
    // Decrement the scanLine to draw the next printStep lines
    level.scanLine -= level.printStep;
  }
}
