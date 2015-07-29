require 'fileutils'

class FileStorage
  def initialize(verbose: false)
    @verbose = verbose
  end

  def store(path:, content:)
    puts "Saving to: #{path}" if @verbose

    dirname = File.dirname(path)

    FileUtils.mkdir_p(dirname)

    open(path, "wb") do |file|
      file.write(content)
    end
  end
end
