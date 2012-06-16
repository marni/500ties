

app = require './app'

app.listen 3099
console.log "500ties.com listening on port %d in %s mode", app.address().port, app.settings.env

