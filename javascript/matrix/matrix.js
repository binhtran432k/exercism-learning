//
// This is only a SKELETON file for the 'Matrix' exercise. It's been provided as a
// convenience to get you started writing code faster.
//

export class Matrix {
  #mat;

  constructor(raw) {
    const rows = raw.split("\n");
    this.#mat = new Array(rows.length);
    for (let i = 0; i < rows.length; i++) {
      const cols = rows[i].split(" ");
      this.#mat[i] = new Array(cols.length);
      for (let j = 0; j < cols.length; j++) {
        this.#mat[i][j] = Number(cols[j]);
      }
    }
  }

  get rows() {
    return this.#mat.slice();
  }

  get columns() {
    if (this.#mat.length === 0) return [];

    const mat = new Array(this.#mat[0].length);
    for (let i = 0; i < mat.length; i++) {
      mat[i] = new Array(this.#mat.length);
    }

    for (let i = 0; i < this.#mat.length; i++) {
      for (let j = 0; j < this.#mat[i].length; j++) {
        mat[j][i] = this.#mat[i][j];
      }
    }
    return mat;
  }
}
