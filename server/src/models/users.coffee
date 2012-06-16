###
#
# DiveClub.me
# (C) 2012 Ngarua Technologies.
#
# Models, types definitions and DB management.
#
# Users and User management.
#
###

module.exports = (app) ->

    UserSchema = new app.mongoose.Schema({})
    mongooseAuth = require 'mongoose-auth'

    UserSchema.plugin app.mongooseAuth,
        everymodule:
            everyauth:
                User: () -> return User
                moduleTimeout: -1

        password:
            extraParams:
                email: String
                first_name: String
                last_last: String
                diver_id: String
                diver_qualifications: String
            everyauth:
                getLoginPath: '/user/login'
                postLoginPath: '/user/login'
                loginView: 'users/login.jade'
                getRegisterPath: '/user/register'
                postRegisterPath: '/user/register'
                registerView: 'users/register.jade'
                loginSuccessRedirect: '/'
                registerSuccessRedirect: '/'

        twitter:
            everyauth:
                myHostname: 'http://127.0.0.1:3099'
                consumerKey: app.conf.auth.twit.consumerKey
                consumerSecret: app.conf.auth.twit.consumerSecret
                redirectPath: '/'

        facebook:
            everyauth:
                myHostname: 'http://127.0.0.1:3099'
                appId: app.conf.auth.facebook.appId
                appSecret: app.conf.auth.facebook.appSecret
                redirectPath: '/'
            
        google:
            everyauth:
                myHostname: 'http://127.0.0.1:3099'
                appId: app.conf.auth.google.clientId
                appSecret: app.conf.auth.google.clientSecret
                redirectPath: '/'
                scope: 'https://www.googleapis.com/auth/userinfo.email https://www.googleapis.com/auth/userinfo.profile'
                # scope: 'http://www.google.com/calendar/feeds/ https://www.google.com/m8/feeds/'


    User = app.mongoose.model 'User', UserSchema

    return {User: User}

# Authentication
#

#everyauth.twitter.consumerKey('ePAp2uO0sQthTzXqwL6g').consumerSecret('BKJdCqQh3sj6wemFUZXzc0UqN2CwHYQViuRAlyXjh3Y')
#      .findOrCreateUser( (session, accessToken, accessTokenSecret, twitterUserMetadata) ->
#          # find or create user logic goes here
#          console.log 'inside twitter auth, done'
#          console.log 'got access token: '+accessToken
#          console.log 'got user metadata: '+twitterUserMetadata)
#              .redirectPath('/')
