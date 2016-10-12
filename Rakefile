require "./setup/android"

HOME = ENV['HOME']
DOTFILES = File.dirname(__FILE__)

DOTS = FileList["dot/*"]

def dotname(f)
  "#{HOME}/.#{File.basename(f)}"
end

DOTS.each do |f|
  file dotname(f) do |t|
    sh "ln", "-sb", "#{DOTFILES}/#{f}", t.name
  end
end

desc "Syncrhonize all files from dot/<name> into $HOME/.<name>"
task :sync => DOTS.map {|f| dotname(f)}

desc "Import $HOME/.<name> into dot/<name>"
task :import, [:name] do |t, args|
  name = args[:name].gsub /^\./, ''

  home = "#{HOME}/.#{name}"
  dot  = "#{DOTFILES}/dot/#{name}"
  
  if !File.exists? home
    puts "File #{home} does not exist."
    exit 1
  end

  if File.exists? dot
    puts "File #{dot} already exists."
    exit 1
  end

  mv home, dot
  sh "ln", "-sb", dot, home
end
