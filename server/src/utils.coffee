###

Utilities and tools.
Useful functions. Keept it clean.
If a function is specific to a single module, 
place it where it is most appropriate.

###



###
slugify - converts a text into URLable slug

http://code.activestate.com/recipes/577787/ (r2)
###
_slugify_strip_re = /[^\w\s-]/g
_slugify_hyphenate_re = /[-\s]+/g
slugify = (s) ->
    s = s.replace(_slugify_strip_re, '').trim().toLowerCase()
    s = s.replace(_slugify_hyphenate_re, '-')
    return s
module.exports.slugify = slugify




