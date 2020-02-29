HOME = ENV['HOME']

DOTS = FileList["dot/*"]

def linked dot
  File.expand_path File.join(HOME, "." + File.basename(dot))
end

desc "Link all #{File.dirname(__FILE__)}/dot/* as ~/.*"
task :link => :unlink do
  DOTS.each do |dot|
    sh "ln", "-s", File.expand_path(dot), linked(dot)
  end
end

desc "Unlink all ~/.* files"
task :unlink do
  DOTS.each do |dot|
    l = linked dot
    sh "unlink", l if File.exists? l
  end
end

task :default do
   puts "Do `rake link` to link all dot/* to .*"
   puts "Do `rake unlink` to unlink all .* from dot/*"
end
