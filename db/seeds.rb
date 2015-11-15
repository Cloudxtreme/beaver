require 'sinatra/activerecord'
require_relative '../models/template_type.rb'

TemplateType.create(name: 'pxe')
TemplateType.create(name: 'kickstart')
