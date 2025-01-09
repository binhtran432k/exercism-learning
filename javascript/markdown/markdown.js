// @ts-check

const LineEvent = {
  None: 0,
  StartList: 1,
  EndListBefore: 2,
};

/**
 * @typedef {[result: string|null, event: number]} MarkdownResult
 * @typedef {[result: string, event: number]} FinalMarkdownResult
 */

/**
 * @param {string} text
 * @param {string} tag
 *
 * @returns {string}
 */
function wrapTag(text, tag) {
  return `<${tag}>${text}</${tag}>`;
}

/**
 * @param {string} text
 * @param {string} tag
 *
 * @returns {boolean}
 */
function isTag(text, tag) {
  return text.startsWith(`<${tag}>`);
}

/**
 * @param {string} markdown
 * @param {string} delimiter
 * @param {string} tag
 *
 * @returns {string}
 */
function parseDelimiter(markdown, delimiter, tag) {
  const pattern = new RegExp(`${delimiter}(.+)${delimiter}`);
  const replacement = `<${tag}>$1</${tag}>`;
  return markdown.replace(pattern, replacement);
}

/**
 * @param {string} markdown
 *
 * @returns {string}
 */
function parseBold(markdown) {
  return parseDelimiter(markdown, "__", "strong");
}

/**
 * @param {string} markdown
 *
 * @returns {string}
 */
function parseItalic(markdown) {
  return parseDelimiter(markdown, "_", "em");
}

/**
 * @param {string} markdown
 * @param {number} state
 *
 * @returns {string}
 */
function parseText(markdown, state) {
  const parsedText = parseItalic(parseBold(markdown));
  if (state === LineEvent.InList) return parsedText;
  else return wrapTag(parsedText, "p");
}

/**
 * @param {string} markdown
 * @param {boolean} isInList
 *
 * @returns {MarkdownResult}
 */
function parseHeader(markdown, isInList) {
  let count = 0;
  for (let i = 0; i < markdown.length && markdown[i] === "#"; i++) count += 1;
  if (count === 0 || count > 6) return [null, LineEvent.None];
  const headerTag = `h${count}`;
  const headerHtml = wrapTag(markdown.substring(count + 1), headerTag);
  return [headerHtml, isInList ? LineEvent.EndListBefore : LineEvent.None];
}

/**
 * @param {string} markdown
 * @param {boolean} isInList
 *
 * @returns {MarkdownResult}
 */
function parseLineItem(markdown, isInList) {
  if (markdown.startsWith("*")) {
    const innerHtml = wrapTag(
      parseText(markdown.substring(2), LineEvent.InList),
      "li",
    );
    return [innerHtml, isInList ? LineEvent.None : LineEvent.StartList];
  }
  return [null, LineEvent.None];
}

/**
 * @param {string} markdown
 * @param {boolean} isInList
 *
 * @returns {MarkdownResult}
 */
function parseParagraph(markdown, isInList) {
  return [
    parseText(markdown, LineEvent.None),
    !isInList ? LineEvent.None : LineEvent.EndListBefore,
  ];
}

/**
 * @param {string} markdown
 * @param {boolean} isInList
 *
 * @returns {FinalMarkdownResult}
 */
function parseLine(markdown, isInList) {
  let [result, event] = parseHeader(markdown, isInList);
  if (result === null) [result, event] = parseLineItem(markdown, isInList);
  if (result === null) [result, event] = parseParagraph(markdown, isInList);
  if (result === null) throw new Error("Invalid markdown");
  return [result, event];
}

/**
 * @param {string} markdown
 *
 * @returns {string}
 */
export function parse(markdown) {
  const lines = markdown.split("\n");
  let result = "";
  let listDepth = 0;
  for (let i = 0; i < lines.length; i++) {
    const [lineResult, lineEvent] = parseLine(lines[i], listDepth > 0);
    if (lineEvent === LineEvent.StartList) {
      listDepth++;
      result += "<ul>";
    } else if (lineEvent === LineEvent.EndListBefore) {
      listDepth--;
      result += "</ul>";
    }
    result += lineResult;
  }
  while (listDepth > 0) {
    listDepth--;
    result += "</ul>";
  }
  return result;
}
