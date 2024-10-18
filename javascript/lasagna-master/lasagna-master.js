/// <reference path="./global.d.ts" />
// @ts-check

/**
 * @param {number} [remainTime]
 * @returns {string}
 */
export function cookingStatus(remainTime) {
  if (remainTime === 0) return "Lasagna is done.";
  if (!remainTime) return "You forgot to set the timer.";
  return "Not done, please wait.";
}

/**
 * @param {string[]} layers
 * @param {number} avgTime
 * @returns {number}
 */
export function preparationTime(layers, avgTime = 2) {
  return layers.length * avgTime;
}

/**
 * @param {string[]} layers
 * @returns {{noodles: number; sauce: number;}}
 */
export function quantities(layers) {
  return {
    noodles: layers.filter((x) => x === "noodles").length * 50,
    sauce: layers.filter((x) => x === "sauce").length * 0.2,
  };
}

/**
 * @param {string[]} friendsList
 * @param {string[]} myList
 * @returns {void}
 */
export function addSecretIngredient(friendsList, myList) {
  myList.push(friendsList[friendsList.length - 1]);
}

/**
 * @param {Record<string, number>} recipe
 * @param {number} numOfPortion
 */
export function scaleRecipe(recipe, numOfPortion) {
  return Object.fromEntries(
    Object.entries(recipe).map(([k, v]) => [k, (v * numOfPortion) / 2]),
  );
}
