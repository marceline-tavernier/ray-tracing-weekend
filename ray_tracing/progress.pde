// Print the progress of a/b
void printProgress(int a, int b) {
  println("Scanlines : " + (b - a) + "/" + b);
  surface.setTitle(((b - a) * 100.0 / b) + "%");
}

// Print when it's done !!!
void printDone() {
  println("Done !!! at " + int(frameRate) + " fps");
  int ms = millis();
  int s = millis() / 1000;
  int m = s / 60;
  println("Took : " + nf(m, 2) + ":" + nf((s % 60), 2) + ":" + nf((ms % 1000), 3));
}
