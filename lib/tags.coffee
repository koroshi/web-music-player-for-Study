exports = module.exports = {}

exports.parse = (args, defaults, replacements)->
  options = {}
  if (typeof defaults is "object" && !(defaults instanceof Array))
    options = defaults

  if(typeof replacements is 'object' && !(replacements instanceof Array))

    for i in args
      arg = i
      if arg.charAt(0) is '-' && arg.charAt(1) isnt '-'
        arg = arg.substr(1)
#        if arg.substr(0,2) is '--'
#          arg = arg.substr(2)
        if arg.indexOf('=') isnt -1
          arg = arg.split('=')
          keyst = arg.shift()
          value = arg.join('=')

          arg = keyst.split('')
          key = arg.pop()
          if replacements.hasOwnProperty(key)
            key = replacements[key]
          args.push("--" + key + "=" + value);
        else
          arg = arg.split('')
        for key  in arg
          if replacements.hasOwnProperty(key)
            key = replacements[key]
            args.push("--" + key );
#    for i in args
#      arg = i

#
  for i in args
    arg = i
    if arg.substr(0,2) is '--'
      arg = arg.substr(2)
    else
      continue
    if arg.indexOf('=') isnt -1
      arg = arg.split('=')
      key = arg.shift()
      value = arg.join("=")

      if /^[0-9]+$/.test(value)
        value = parseInt(value, 10)
      options[key] = value
    else
      options[arg] = true
  return options