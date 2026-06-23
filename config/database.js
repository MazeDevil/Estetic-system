async function getConnection(){
    const connection = await mysql.createConnection({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'clinica-estetica'
    });
    return connection;

}

app.listen(PORT, function(){
    console.log(`App de exemplo escutando na porta ${PORT}`);
});