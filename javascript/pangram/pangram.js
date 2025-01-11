//
// This is only a SKELETON file for the 'Pangram' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const isPangram = (input) => {
  const lowerInput = input.toLowerCase();
  return [..."abcdefghijklmnopqrstuvwxyz"].every((x) => lowerInput.includes(x));
};
