// @ts-check

export class Size {
  /**
   * @param {number} width
   * @param {number} height
   */
  constructor(width = 80, height = 60) {
    this.width = width;
    this.height = height;
  }

  /**
   * @param {number} width
   * @param {number} height
   *
   * @returns {void}
   */
  resize(width, height) {
    this.width = width;
    this.height = height;
  }
}

export class Position {
  /**
   * @param {number} x
   * @param {number} y
   */
  constructor(x = 0, y = 0) {
    this.x = x;
    this.y = y;
  }

  /**
   * @param {number} x
   * @param {number} y
   *
   * @returns {void}
   */
  move(x, y) {
    this.x = x;
    this.y = y;
  }
}

export class ProgramWindow {
  constructor() {
    this.screenSize = new Size(800, 600);
    this.size = new Size();
    this.position = new Position();
  }

  /**
   * @param {Size} size
   *
   * @returns {void}
   */
  resize(size) {
    const maxWidth = this.screenSize.width - this.position.x;
    this.size.width = Math.max(1, Math.min(maxWidth, size.width));

    const maxHeight = this.screenSize.height - this.position.y;
    this.size.height = Math.max(1, Math.min(maxHeight, size.height));
  }

  /**
   * @param {Position} position
   *
   * @returns {void}
   */
  move(position) {
    const maxX = this.screenSize.width - this.size.width;
    this.position.x = Math.max(0, Math.min(maxX, position.x));

    const maxY = this.screenSize.height - this.size.height;
    this.position.y = Math.max(0, Math.min(maxY, position.y));
  }
}

/**
 * @param {ProgramWindow} programWindow
 *
 * @returns {ProgramWindow}
 */
export function changeWindow(programWindow) {
  programWindow.size.width = 400;
  programWindow.size.height = 300;
  programWindow.position.x = 100;
  programWindow.position.y = 150;
  return programWindow;
}
