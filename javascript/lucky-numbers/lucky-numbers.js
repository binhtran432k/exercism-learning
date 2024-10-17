// @ts-check

/**
 * Calculates the sum of the two input arrays.
 *
 * @param {number[]} array1
 * @param {number[]} array2
 * @returns {number} sum of the two arrays
 */
export function twoSum(array1, array2) {
  let sum = 0;
  for (let i = 0; i < array1.length; i++) {
    sum += array1[i] * 10 ** (array1.length - 1 - i);
  }
  for (let i = 0; i < array2.length; i++) {
    sum += array2[i] * 10 ** (array2.length - 1 - i);
  }
  return sum;
}

/**
 * Checks whether a number is a palindrome.
 *
 * @param {number} value
 * @returns {boolean} whether the number is a palindrome or not
 */
export function luckyNumber(value) {
  while (value !== 0) {
    const valueFactor = value <= 1 ? 1 : 10 ** Math.floor(Math.log10(value));
    const left = Math.floor(value / valueFactor);
    const right = value % 10;
    if (left !== right) return false;
    value -= left * valueFactor;
    value = Math.floor(value / 10);
  }
  return true;
}

/**
 * Determines the error message that should be shown to the user
 * for the given input value.
 *
 * @param {string|null|undefined} input
 * @returns {string} error message
 */
export function errorMessage(input) {
  if (!input) return "Required field";
  if (isNaN(Number(input)) || Number(input) === 0)
    return "Must be a number besides 0";
  return "";
}
