const clienteFields = [
  { name: 'id_cliente', label: 'Codigo', type: 'number', required: true },
  { name: 'cliente_nome', label: 'Nome', type: 'text', required: true },
  { name: 'cliente_sobrenome', label: 'Sobrenome', type: 'text', required: true },
  { name: 'cliente_cpf', label: 'CPF', type: 'text', required: true, maxlength: 13 },
  { name: 'cliente_nascimento', label: 'Nascimento', type: 'date', required: true },
  { name: 'cliente_sexo', label: 'Sexo', type: 'text', required: true },
  { name: 'cliente_observacoes', label: 'Observacoes', type: 'textarea', required: true },
];

const profissionalFields = [
  { name: 'id_profissional', label: 'Codigo', type: 'number', required: true },
  { name: 'profissional_nome', label: 'Nome', type: 'text', required: true },
  { name: 'profissional_sobrenome', label: 'Sobrenome', type: 'text', required: true },
  { name: 'profissional_cpf', label: 'CPF', type: 'text', required: true, maxlength: 13 },
  { name: 'profissional_crm', label: 'CRM', type: 'text', required: true },
  { name: 'profissional_status', label: 'Ativo', type: 'select', required: true, options: [
    { value: 1, label: 'Sim' },
    { value: 0, label: 'Nao' },
  ] },
];

const departamentoFields = [
  { name: 'id_departamento', label: 'Codigo', type: 'number', required: true },
  { name: 'departamento_nome', label: 'Nome', type: 'text', required: true },
  { name: 'departamento_descricao', label: 'Descricao', type: 'textarea', required: true },
];

const servicoFields = [
  { name: 'id_servico', label: 'Codigo', type: 'number', required: true },
  { name: 'servico_nome', label: 'Nome', type: 'text', required: true },
  { name: 'servico_duracao', label: 'Duracao em minutos', type: 'number', required: true },
  { name: 'Departamento_id_departamento', label: 'Departamento', type: 'select', required: true, lookup: 'departamentos' },
];

const agendamentoFields = [
  { name: 'id_agendamento', label: 'Codigo', type: 'number', required: true },
  { name: 'agendamento_data', label: 'Data', type: 'date', required: true },
  { name: 'agendamento_horaInicio', label: 'Inicio', type: 'datetime-local', required: true },
  { name: 'agendamento_horaFim', label: 'Fim', type: 'datetime-local', required: true },
  { name: 'agendamento_status', label: 'Status', type: 'select', required: true, options: [
    { value: 'marcado', label: 'Marcado' },
    { value: 'realizado', label: 'Realizado' },
    { value: 'cancelado', label: 'Cancelado' },
  ] },
  { name: 'agendamento_observacao', label: 'Observacao', type: 'textarea' },
  { name: 'Profissional_id_Profissional', label: 'Profissional', type: 'select', required: true, lookup: 'profissionais' },
  { name: 'Servico_id_servico', label: 'Servico', type: 'select', required: true, lookup: 'servicos' },
];

module.exports = {
  clientes: clienteFields,
  profissionais: profissionalFields,
  departamentos: departamentoFields,
  servicos: servicoFields,
  agendamentos: agendamentoFields,
};
