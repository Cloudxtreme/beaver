require 'parseconfig'

CONFIG_PATH = '/etc/beaver/beaver.conf'

module Config
extend self
  @config = ParseConfig.new(CONFIG_PATH)
  @config.get_groups.each{ |i| define_method(i){ @config[i] }}
end
