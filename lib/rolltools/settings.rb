require 'yaml'
require 'pry'

module Rolltools::Settings

  def self.settings=(settings)
    @@settings = settings
  end

  def self.settings
    @@settings ||= YAML::load_file "#{Dir.home}/.rolltools.yml" rescue nil
    @@settings ||= {}
  end

  def self.set(key, value)
    settings[key] = value
    File.open("#{Dir.home}/.rolltools.yml", "w") do |file|
      file.write settings.to_yaml
    end
  end

  def self.get(key)
    settings[key]
  end

end