struct SvgChock::Watcher
  getter pattern : String
  getter files = [] of String
  getter timestamps = {} of String => Time

  def initialize
    @pattern = File.expand_path(File.join(SvgChock.config.dir, "**", "*.svg"))
    collect_files
  end

  def changes : Array(String)
    delete_missing
    Array(String).new.tap do |changed|
      find_changes(changed)
      log_changes(changed)
    end
  end

  private def find_changes(changed)
    Dir.glob(pattern) do |file|
      if !files.includes?(file)
        changed << file
        files << file
      elsif timestamps[file] != file_creation_date(file)
        changed << file
        timestamps[file] = file_creation_date(file)
      end
    end
  end

  private def log_changes(changed)
    changed.each do |file|
      Log.info { "SvgChock: detected change in #{file}".colorize(:cyan) }
    end
  end

  private def delete_missing
    files.reject! do |file|
      if !File.exists?(file)
        timestamps.delete(file)
        true
      else
        false
      end
    end
  end

  private def collect_files : Void
    Dir.glob(pattern) do |file|
      files << file
      timestamps[file] = file_creation_date(file)
    end
  end

  private def file_creation_date(file : String)
    File.info(file).modification_time
  end
end
