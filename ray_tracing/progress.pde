
// Change the title to show the progress
void printProgress(int a, int b) {
  surface.setTitle(((b - a) * 100.0 / b) + "%");
}

// Change the title when finished to show the name
void printDone() {
  surface.setTitle("Ray tracing #1 : In one weekend");
}
