

app = require './app'

app.listen 3060
console.log "DiveClub.me listening on port %d in %s mode", app.address().port, app.settings.env

