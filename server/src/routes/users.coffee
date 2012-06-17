
###
#
# Users
#
# Home page,
# processing the ogin process, 
# user registration, verification, 
# users profile management
#
# 
###




module.exports = (app) ->

    User = app.users.User
    ObjectId = app.mongoose.Schema.ObjectId

    # Landing page
    app.get '/', (req, res) ->
        res.render 'lending'
        return

    # Home Page
    app.get '/beta', (req, res) ->
        if req.session.auth and req.session.auth.loggedIn
            usrId = req.user.id
            User.findOne {_id: usrId}, (err, doc) ->
                if doc is null
                    console.log 'No User Object found'
                    return res.render 'home_page'
                # We got the user, need to get all his clubs
                # and show it on the front page
                res.render 'home_page'
        else
            res.render 'home_page'
    
    # user notification from landing page
    app.post '/notify', (req, res) ->
        email = req.body.email
        fs = require 'fs'
        stream = fs.createWriteStream 'ties_emals.txt', 'flags': 'a'
        stream.once 'open', (fd) ->
            stream.write email
            stream.write '\n'
        res.render 'lending_thanks'
    
    # user login 
    app.get '/user/login', (req, res) ->
        res.render 'users/login'
    

    # user profile
    app.get '/user/profile', (req, res) ->
        if req.session.auth and req.session.auth.loggedIn
            usrId = req.user._id
            User.findOne {_id: usrId}, (err, usr) ->
                if usr is null
                    console.log 'No User object for this user.'
                    usr = {}
                res.render 'users/user_settings',
                    userProfile: usr
        else
            res.render 'users/login'

    app.post '/user/profile/:usrId/update', (req, res) ->
        User.findOne {_id: req.params.usrId}, (err, doc) ->
            if doc
                usr = doc
            else
                # handle problem with User
                return res.render 'home_page'
            usr.first_name = req.body.firstname
            usr.last_name = req.body.lastname
            usr.email = req.body.email
            usr.diver_id = req.body.diver_id
            usr.diver_qualifications = req.body.diver_qualifications
            usr.save (err) ->
                if (err)
                    console.log err
            # find the profile and deal with it
            res.render 'users/user_settings', userProfile: usr
    

    # add new User
    app.get '/user/new', (req, res) ->
        res.render 'users/login'


    # display connect form
    app.get '/connect', (req, res) ->
        res.render 'connect'

    
    # display connect form
    app.post '/connect', (req, res) ->
        email = req.body.email
        
        if email
            uuid = require 'node-uuid'
            #send email and add connection to DB
            invitationModel = db.model 'Invitation'
            invitation = new invitationModel()
            invitation.email = email
            invitation.code = uuid.v4()
            
            invitation.save (err) ->
                if (err)
                    console.log err

            nodemailer = 'nodemailer'

            nodemailer.send {
               host : 'smtp.gmail.com'            
               port : '25'                    
               domain : '500ties.com'           
               to : email
               from : 'info@500ties.com'
               subject : 'Invitation'
               body: 'Hello! You got the invitation from.' + req.user.first_name
               authentication : 'login'        
               username : 'info@500ties.com'       
               password : '500tiesaklsw'        
               }, (err, result) -> 
                 if(err)
                    console.log(err) 
               

    
    # user profile
    app.get '/user/profile/:usrId/public', (req, res) ->

        User.findOne {_id: usrId}, (err, usr) ->
            if usr is null
                console.log 'No User object for this user.'
                usr = {}
            res.render 'users/public_profile',
                userProfile: usr

