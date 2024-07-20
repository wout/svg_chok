require "colorize"
require "kemal"
require "xml"
require "yaml"

require "./svg_chok/**"
require "./routes/**"

module SvgChok
  class_getter config = Config.from_yaml(File.open("./config.yml"))
end

Dir.mkdir_p(SvgChok.config.dir)

Kemal.run(SvgChok.config.port)
