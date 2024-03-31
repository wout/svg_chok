struct SvgChock::Svg
  getter absolute_path : String
  getter relative_path : String
  getter name : String

  def initialize(path)
    @absolute_path = File.expand_path(path)
    @relative_path = absolute_path.sub(File.expand_path(SvgChock.config.dir), "")
    @name = relative_path.sub(/^\//, "").sub(/\.svg$/, "")
  end

  def content
    File.read(absolute_path)
  end

  def encoded_content
    URI.encode_path(content)
  end

  def metadata
    @metadata ||= SvgChock::Metadata.new(content)
  end

  def self.all
    Dir.glob(File.join(SvgChock.config.dir, "**/*.svg")).map do |path|
      new(path)
    end
  end

  def self.find(id)
    path = File.join(SvgChock.config.dir, id)

    new(path) if File.exists?(path)
  end
end
