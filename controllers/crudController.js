const Departamento = require('../models/Departamento');
const Profissional = require('../models/Profissional');
const Servico = require('../models/Servico');

async function buildLookups(fields) {
  const lookups = {};

  if (fields.some((field) => field.lookup === 'departamentos')) {
    lookups.departamentos = (await Departamento.findAll()).map((item) => ({
      value: item.id_departamento,
      label: item.departamento_nome,
    }));
  }

  if (fields.some((field) => field.lookup === 'profissionais')) {
    lookups.profissionais = (await Profissional.findAll()).map((item) => ({
      value: item.id_profissional,
      label: `${item.profissional_nome} ${item.profissional_sobrenome}`,
    }));
  }

  if (fields.some((field) => field.lookup === 'servicos')) {
    lookups.servicos = (await Servico.findAll()).map((item) => ({
      value: item.id_servico,
      label: item.servico_nome,
    }));
  }

  return lookups;
}

function withLookupOptions(fields, lookups) {
  return fields.map((field) => ({
    ...field,
    options: field.lookup ? lookups[field.lookup] || [] : field.options,
  }));
}

function createCrudController({ model, title, route, fields }) {
  return {
    async index(req, res, next) {
      try {
        const rows = await model.findAll();
        res.render('crud/list', { title, route, rows, fields, primaryKey: model.primaryKey });
      } catch (error) {
        next(error);
      }
    },

    async create(req, res, next) {
      try {
        const lookups = await buildLookups(fields);
        res.render('crud/form', {
          title: `Novo ${title.slice(0, -1)}`,
          route,
          fields: withLookupOptions(fields, lookups),
          item: {},
          action: route,
          method: 'POST',
        });
      } catch (error) {
        next(error);
      }
    },

    async store(req, res, next) {
      try {
        await model.create(req.body);
        res.redirect(route);
      } catch (error) {
        next(error);
      }
    },

    async edit(req, res, next) {
      try {
        const item = await model.findById(req.params.id);
        const lookups = await buildLookups(fields);

        if (!item) {
          return res.status(404).render('error', {
            title: 'Registro nao encontrado',
            message: 'Nao encontramos o cadastro solicitado.',
          });
        }

        return res.render('crud/form', {
          title: `Editar ${title.slice(0, -1)}`,
          route,
          fields: withLookupOptions(fields, lookups),
          item,
          action: `${route}/${req.params.id}?_method=PUT`,
          method: 'POST',
        });
      } catch (error) {
        next(error);
      }
    },

    async update(req, res, next) {
      try {
        await model.update(req.params.id, req.body);
        res.redirect(route);
      } catch (error) {
        next(error);
      }
    },

    async destroy(req, res, next) {
      try {
        await model.delete(req.params.id);
        res.redirect(route);
      } catch (error) {
        next(error);
      }
    },
  };
}

module.exports = createCrudController;
