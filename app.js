require('dotenv').config();

const path = require('path');
const express = require('express');
const { engine } = require('express-handlebars');
const methodOverride = require('method-override');
const db = require('./config/database');

const clienteRoutes = require('./routes/clienteRoutes');
const profissionalRoutes = require('./routes/profissionalRoutes');
const departamentoRoutes = require('./routes/departamentoRoutes');
const servicoRoutes = require('./routes/servicosRoutes');
const agendamentoRoutes = require('./routes/agendamentoRoutes');
const consultaRoutes = require('./routes/consultaRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

app.engine(
  'handlebars',
  engine({
    defaultLayout: 'main',
    helpers: {
      eq: (a, b) => String(a) === String(b),
      formatDate(value) {
        if (!value) return '';
        return new Date(value).toISOString().slice(0, 10);
      },
      formatDateTime(value) {
        if (!value) return '';
        const date = new Date(value);
        return date.toISOString().slice(0, 16);
      },
      fieldValue(item, field) {
        const value = item?.[field.name];
        if (!value) return '';
        if (field.type === 'date') return String(value).slice(0, 10);
        if (field.type === 'datetime-local') return String(value).replace(' ', 'T').slice(0, 16);
        return value;
      },
      isSelected(item, field, value) {
        return String(item?.[field.name] ?? '') === String(value);
      },
    },
  })
);

app.set('view engine', 'handlebars');
app.set('views', path.join(__dirname, 'views'));

app.use(express.urlencoded({ extended: true }));
app.use(express.json());
app.use(methodOverride('_method'));
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', (req, res) => {
  res.render('home', {
    title: 'Estetic',
    cards: [
      { label: 'Clientes', href: '/clientes', description: 'Cadastro, edicao e listagem de clientes.' },
      { label: 'Profissionais', href: '/profissionais', description: 'Equipe, CPF, CRM e status de atendimento.' },
      { label: 'Departamentos', href: '/departamentos', description: 'Areas de atendimento da clinica.' },
      { label: 'Servicos', href: '/servicos', description: 'Procedimentos, duracao e departamento.' },
      { label: 'Agendamentos', href: '/agendamentos', description: 'Agenda conectada a profissionais e servicos.' },
      { label: 'Consultas SQL', href: '/consultas/agenda', description: 'Relatorio com JOIN entre tabelas do banco.' },
    ],
  });
});

app.use('/clientes', clienteRoutes);
app.use('/profissionais', profissionalRoutes);
app.use('/departamentos', departamentoRoutes);
app.use('/servicos', servicoRoutes);
app.use('/agendamentos', agendamentoRoutes);
app.use('/consultas', consultaRoutes);

app.use((req, res) => {
  res.status(404).render('error', {
    title: 'Pagina nao encontrada',
    message: 'A rota solicitada nao existe.',
  });
});

app.use((error, req, res, next) => {
  console.error(error);
  res.status(500).render('error', {
    title: 'Erro no sistema',
    message: 'Nao foi possivel concluir a operacao. Verifique a conexao com o banco e tente novamente.',
    details: process.env.NODE_ENV === 'development' ? error.message : null,
  });
});

app.listen(PORT, async () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);

  try {
    await db.testConnection();
  } catch (error) {
    console.log('O servidor iniciou, mas as paginas que consultam o banco exibirao erro ate a conexao ser corrigida.');
  }
});
