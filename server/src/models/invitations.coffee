###
#
# 500ties
#
# Models, types definitions for managing invitations
#
###


module.exports = (mongoose) ->

    # Invitation
    InvitationSchema = new mongoose.Schema
        email: String
        code: String

    mongoose.model 'Invitation', InvitationSchema
    Person = mongoose.model 'Invitation'

    # export what this module provides
    return {
        Invitation: Invitation
    }


