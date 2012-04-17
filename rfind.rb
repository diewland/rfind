def deep_in_dir(from_str=nil, to_str=nil, pwd=nil)
  pwd = Dir.pwd if pwd.nil?
  Dir.foreach(pwd) do |f|

    next if f == '.'
    next if f == '..'
    next if f == '.svn'

    path = "#{pwd}/#{f}"

    if File.directory?(path)
      puts "-----> #{f}"
      deep_in_dir(from_str, to_str, path)
    else
      puts path
      search_n_replace(path, from_str, to_str)
    end
  end
end

def search_n_replace(filename, from_str=nil, to_str=nil)

  data = []
  # read, replace
  file = File.new(filename, 'r')
  while(line = file.gets)
    if !to_str.nil? # replace
      puts line.gsub!(from_str, to_str) if line.index(from_str)
    elsif !from_str.nil? # seach
      puts line if line.index(from_str)
    end
    data << line
  end
  file.close

  # write
  if !from_str.nil?
    File.open(filename, 'w') do |f2|
      data.each do |d|
        f2.puts d
      end
    end
  end

end

# ----------------------------------------

if __FILE__ == $0
  # search_n_replace('x', '.csv')
  # search_n_replace('x', '.csv', '.txt')
  # deep_in_dir('trans_type', 'trans_type')

  from_str = ARGV[0]
  to_str = ARGV[0]
  deep_in_dir(from_str, to_str)

end
