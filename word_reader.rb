class WordReader
  def read_from_args
    return ARGV[0]
  end

  def read_from_file(file_name)
    return nil if !File.exist?(file_name) #TODO rescue file exist

    f = File.new(file_name, "r:UTF-8")
    lines = f.readlines
    f.close

    lines.sample.chomp
  end
end
