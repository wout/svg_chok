require "yaml"
require "kemal"
require "./svg_chock/**"
require "./routes/**"

module SvgChock
  class_getter config = Config.from_yaml(File.open("./config.yml"))
end

Dir.mkdir_p(SvgChock.config.dir)

Kemal.run(SvgChock.config.port)
