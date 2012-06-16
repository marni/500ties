###
# 
# This is a meta include of all the routes
#
# Keep your routes in appropriate file as per your module
#
# Mariusz Nowostawski
#
###

fs = require('fs')

module.exports = (app) ->
	fs.readdirSync(__dirname).forEach( (file) ->
		if file == 'index.js' || file.charAt(0) == '.'
			return null
		extension = file.split('.')
		if extension.pop() == 'js'
			name = file.substr(0, file.indexOf('.'))
			require('./' + name)(app))
	return null
