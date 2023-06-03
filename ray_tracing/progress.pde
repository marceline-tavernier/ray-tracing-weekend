
// The variables to manage the time
int timer = 0;
int timeTaken = 0;

/////////////////////////////////

// Change the title to show the progress
void printProgress(int a, int b) {

  // Get the percentage, the time taken so far and calculate the time remaining based on that
  float percent = (b - a) * 100.0 / b;
  int timeTaken = millis() - timer;
  int timeRemaining = int(timeTaken * 100 / percent) - timeTaken;

  // Set the title
  surface.setTitle(nf(percent, 2, 3) + " % - " + formatTime(timeRemaining) + " remaining");
}

// Change the title when finished to show the name and the time taken to render the image
void printDone() {
  surface.setTitle("Ray tracing #1 : In one weekend - " + formatTime(endTimer()));
}

// Format the time to only include the needed info
String formatTime(int time) {

  // Calculate the ms, sec, min and hours
  int ms = time % 1000;
  int s = (time / 1000) % 60;
  int m = (time / 1000 / 60) % 60;
  int h = (time / 1000 / 60 / 60);

  // Return the correct string
  if (h > 0) {
    return h + " h, " + m + " min, " + s + " sec and " + ms + " ms";
  } else if (m > 0) {
    return m + " min, " + s + " sec and " + ms + " ms";
  } else if (s > 0) {
    return s + " sec and " + ms + " ms";
  }
  return ms + " ms";
}

// Start the timer and reset the previous time taken to generate the image
void startTimer() {
  timeTaken = 0;
  timer = millis();
}

// End the timer and save it
int endTimer() {
  if (timeTaken == 0) {
    timeTaken = millis() - timer;
  }
  return timeTaken;
}
