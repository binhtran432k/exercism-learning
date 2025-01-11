//
// This is only a SKELETON file for the 'Space Age' exercise. It's been provided as a
// convenience to get you started writing code faster.
//
const ageMap = {
  mercury: 0.2408467,
  venus: 0.61519726,
  earth: 1.0,
  mars: 1.8808158,
  jupiter: 11.862615,
  saturn: 29.447498,
  uranus: 84.016846,
  neptune: 164.79132,
};
const PER_YEAR_EARTH_SECOND = 31_557_600;

export const age = (planet, second) => {
  return (
    Math.round((1e2 * second) / PER_YEAR_EARTH_SECOND / ageMap[planet]) / 1e2
  );
};
