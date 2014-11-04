# file: index.coffee

hogan  = require 'hogan.js'
yaml   = require 'js-yaml'
fs     = require 'fs'
path   = require 'path'
mkdirp = require 'mkdirp'

template_path = './config/templates'

conf = (template_name, target_file)->
  dir = path.dirname target_file
  mkdirp.sync dir
  template = hogan.compile fs.readFileSync "#{template_path}/#{template_name}", 'utf8'
  config = template.render data
  fs.writeFileSync target_file, config
  console.log "#{template_path}/#{template_name} -> #{target_file}"

try
  data = yaml.safeLoad(fs.readFileSync('./config/default.yml', 'utf8'))
catch e
  console.log e

conf 'celeryd', '/etc/default/celeryd'
