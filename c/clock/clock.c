#include "clock.h"
#include <stdio.h>
#include <string.h>

const int HOUR_MINUTES = 60;
const int DAY_MINUTES = 24 * HOUR_MINUTES;

static int normalize_minutes(int minutes) {
  return (minutes < 0 ? DAY_MINUTES : 0) + (minutes % DAY_MINUTES);
}

static void set_text(clock_t *clock, int all_minutes) {
  int hours = all_minutes / HOUR_MINUTES;
  int minutes = all_minutes % HOUR_MINUTES;
  if (hours >= 0 && hours <= 24 && minutes >= 0 && minutes <= 60)
    sprintf(clock->text, "%02d:%02d", hours, minutes);
}

static int minutes_from_text(char text[5]) {
  int hour, minute;
  sscanf(text, "%d:%d", &hour, &minute);
  return (hour * HOUR_MINUTES) + minute;
}

clock_t clock_create(int hour, int minute) {
  clock_t clock;
  set_text(&clock, normalize_minutes(hour * HOUR_MINUTES + minute));
  return clock;
}

clock_t clock_add(clock_t clock, int minute_add) {
  return clock_create(0, minutes_from_text(clock.text) + minute_add);
}

clock_t clock_subtract(clock_t clock, int minute_subtract) {
  return clock_create(0, minutes_from_text(clock.text) - minute_subtract);
}

bool clock_is_equal(clock_t a, clock_t b) { return (!strcmp(a.text, b.text)); }
