module.exports = (srv) => {
    srv.on('testing',(request, response) => {
        return 'Welcome' + request.data.name + '!';
    })
}
