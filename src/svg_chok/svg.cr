struct SvgChok::Svg
  getter absolute_path : String
  getter relative_path : String
  getter name : String

  def initialize(path)
    @absolute_path = File.expand_path(path)
    @relative_path = absolute_path.sub(File.expand_path(SvgChok.config.dir), "")
    @name = relative_path.sub(/^\//, "")
  end

  def content
    File.read(absolute_path)
  end

  def metadata
    @metadata ||= SvgChok::Metadata.new(content)
  end

  def image_path
    File.join("/svgs", "#{relative_path}?t=#{Time.local.to_unix}")
  end

  def self.all
    Dir.glob(File.join(SvgChok.config.dir, "**/*.svg")).map do |path|
      new(path)
    end
  end

  def self.find(id)
    path = File.join(SvgChok.config.dir, id)

    new(path) if File.exists?(path)
  end
end
