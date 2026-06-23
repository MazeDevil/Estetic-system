const db = require('../config/database');

module.exports = {
  async agenda(req, res, next) {
    try {
      const [rows] = await db.query(`
        SELECT *
        FROM vw_agenda_completa
        ORDER BY agendamento_data DESC, agendamento_horaInicio DESC
      `);

      res.render('consultas/agenda', {
        title: 'Consulta de Agendamentos',
        rows,
      });
    } catch (error) {
      next(error);
    }
  },
};
