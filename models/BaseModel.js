const db = require('../config/database');

class BaseModel {
  constructor({ table, primaryKey, columns }) {
    this.table = table;
    this.primaryKey = primaryKey;
    this.columns = columns;
  }

  async findAll() {
    const [rows] = await db.query(`SELECT * FROM \`${this.table}\` ORDER BY \`${this.primaryKey}\` DESC`);
    return rows;
  }

  async findById(id) {
    const [rows] = await db.query(`SELECT * FROM \`${this.table}\` WHERE \`${this.primaryKey}\` = ?`, [id]);
    return rows[0];
  }

  async create(data) {
    const payload = this.clean(data);
    const fields = Object.keys(payload);
    const placeholders = fields.map(() => '?').join(', ');
    const values = fields.map((field) => payload[field]);

    await db.query(
      `INSERT INTO \`${this.table}\` (${fields.map((field) => `\`${field}\``).join(', ')}) VALUES (${placeholders})`,
      values
    );
  }

  async update(id, data) {
    const payload = this.clean(data);
    const fields = Object.keys(payload).filter((field) => field !== this.primaryKey);
    const assignments = fields.map((field) => `\`${field}\` = ?`).join(', ');
    const values = fields.map((field) => payload[field]);

    await db.query(`UPDATE \`${this.table}\` SET ${assignments} WHERE \`${this.primaryKey}\` = ?`, [...values, id]);
  }

  async delete(id) {
    await db.query(`DELETE FROM \`${this.table}\` WHERE \`${this.primaryKey}\` = ?`, [id]);
  }

  clean(data) {
    return this.columns.reduce((payload, column) => {
      if (Object.prototype.hasOwnProperty.call(data, column.name) && data[column.name] !== '') {
        payload[column.name] = data[column.name];
      }
      return payload;
    }, {});
  }
}

module.exports = BaseModel;
