document.querySelectorAll('form[data-confirm]').forEach((form) => {
  form.addEventListener('submit', (event) => {
    const confirmed = window.confirm('Deseja excluir este registro?');
    if (!confirmed) event.preventDefault();
  });
});
