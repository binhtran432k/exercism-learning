#include "reverse_string.h"
#include <stdlib.h>
#include <string.h>

char *reverse(const char *value) {
  int len = strlen(value);
  char *reversed = calloc(len + 1, sizeof(char));

  for (int i = 0; i < len; i++)
    reversed[i] = value[len - 1 - i];
  reversed[len] = '\0';

  return reversed;
}
