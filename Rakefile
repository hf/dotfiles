HOME = ENV['HOME']

DOTS = FileList["dot/*"] - FileList["dot/config"]
CONFIG_DOTS = FileList["dot/config/*"]

def linked dot
  File.expand_path File.join(HOME, "." + dot)
end

desc "Link all #{File.dirname(__FILE__)}/dot/* as ~/.*"
task :link => :unlink do
  DOTS.each do |dot|
    sh "ln", "-s", File.expand_path(dot), linked(File.basename(dot))
  end

  sh "mkdir", "-p", "#{HOME}/.config"

  CONFIG_DOTS.each do |dot|
    sh "ln", "-s", File.expand_path(dot), linked(dot.sub(%r{\A[^/]+/}, ""))
  end
end

desc "Unlink all ~/.* files"
task :unlink do
  DOTS.each do |dot|
    l = linked File.basename(dot)
    sh "unlink", l if File.exist? l
  end

  CONFIG_DOTS.each do |dot|
    l = linked(dot.sub(%r{\A[^/]+/}, ""))
    sh "unlink", l if File.exist? l
  end
end

task :default do
   puts "Do `rake link` to link all dot/* to .*"
   puts "Do `rake unlink` to unlink all .* from dot/*"
end
