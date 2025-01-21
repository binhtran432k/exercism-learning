//
// This is only a SKELETON file for the 'Bob' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export const hey = (message) => {
  message = message.trim();
  if (message.length === 0) {
    return "Fine. Be that way!";
  }
  let isShouting = false;
  for (let i = 0; i < message.length; i++) {
    if (!isShouting && "A" <= message[i] && message[i] <= "Z") {
      isShouting = true;
    } else if ("a" <= message[i] && message[i] <= "z") {
      isShouting = false;
      break;
    }
  }
  const isQuestion = message[message.length - 1] === "?";
  if (isQuestion && isShouting) {
    return "Calm down, I know what I'm doing!";
  }
  if (isQuestion) {
    return "Sure.";
  }
  if (isShouting) {
    return "Whoa, chill out!";
  }
  return "Whatever.";
};
