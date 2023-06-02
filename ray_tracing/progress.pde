
int timer = 0;
int timeTook = 0;

// Change the title to show the progress
void printProgress(int a, int b) {
  float percent = (b - a) * 100.0 / b;
  int timeTook = millis() - timer;
  int timeRemaining = int(timeTook * 100 / percent) - timeTook;
  surface.setTitle(nf(percent, 2, 3) + " % - " + formatTime(timeRemaining) + " remaining");
}

// Change the title when finished to show the name
void printDone() {
  surface.setTitle("Ray tracing #1 : In one weekend - " + formatTime(endTimer()));
}

String formatTime(int time) {
  int ms = time % 1000;
  int s = (time / 1000) % 60;
  int m = (time / 1000 / 60) % 60;
  int h = (time / 1000 / 60 / 60);
  if (h > 0) {
    return h + " h, " + m + " min, " + s + " sec and " + ms + " ms";
  } else if (m > 0) {
    return m + " min, " + s + " sec and " + ms + " ms";
  } else if (s > 0) {
    return s + " sec and " + ms + " ms";
  } else {
    return ms + " ms";
  }
}

void startTimer() {
  timeTook = 0;
  timer = millis();
}

int endTimer() {
  if (timeTook == 0) {
    timeTook = millis() - timer;
  }
  return timeTook;
}
