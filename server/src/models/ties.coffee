###
#
# 500ties
#
# Models, types definitions for managing ties
#
###


module.exports = (mongoose) ->

    # Person 
    PersonSchema = new mongoose.Schema
        user: mongoose.Schema.ObjectId
        bio: String
        url: String
        interests: String
        needs: String
        ties: [mongoose.Schema.ObjectId]
        introductions: [mongoose.Schema.ObjectId]

    mongoose.model 'Person', PersonSchema
    Person = mongoose.model 'Person'


    # Introductions
    IntroductionSchema = new mongoose.Schema
        initiator: mongoose.Schema.ObjectId
        recipient: mongoose.Schema.ObjectId
        date:
            type: Date
            default: Date.now
        last_contact:
            type: Date
            default: Date.now

    # export what this module provides
    return {
        Person: Person
        Introduction: Introduction
    }


