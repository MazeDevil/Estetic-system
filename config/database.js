const mysql = require('mysql2/promise');

const config = {
  host: process.env.DB_HOST || 'localhost',
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'mydb',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  dateStrings: true,
  charset: 'utf8mb4',
};

const pool = mysql.createPool({
  ...config,
});

async function testConnection() {
  try {
    const connection = await pool.getConnection();
    await connection.query('SELECT 1');
    connection.release();
    console.log(`Conectado ao MySQL no banco "${config.database}".`);
  } catch (error) {
    console.error('Erro ao conectar no MySQL.');
    console.error(`Host: ${config.host}:${config.port}`);
    console.error(`Banco: ${config.database}`);
    console.error(`Usuario: ${config.user}`);

    if (error.code === 'ER_BAD_DB_ERROR') {
      console.error('Banco nao encontrado. Execute o arquivo sql/BD.sql no MySQL Workbench.');
    } else if (error.code === 'ER_ACCESS_DENIED_ERROR') {
      console.error('Usuario ou senha incorretos. Confira DB_USER e DB_PASSWORD no arquivo .env.');
    } else if (error.code === 'ECONNREFUSED') {
      console.error('MySQL nao esta rodando ou a porta esta incorreta.');
    }

    throw error;
  }
}

pool.dbConfig = config;
pool.testConnection = testConnection;

module.exports = pool;
