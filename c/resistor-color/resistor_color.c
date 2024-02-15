#include "resistor_color.h"

static resistor_band_t bands[] = {
  COLORS
};

int color_code(resistor_band_t band) { return band; }

const resistor_band_t *colors() { return bands; }
