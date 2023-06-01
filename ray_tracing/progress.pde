
// Change the title to show the progress
void printProgress(int a, int b) {
  surface.setTitle(((b - a) * 100.0 / b) + "%");
}

// Change the title when finished to show the name
void printDone(String nameScene) {
  surface.setTitle(nameScene);
}
