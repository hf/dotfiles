require "#{File.dirname __FILE__}/tools.rb"

APPS_SBT = "#{APPS}/SBT"
APPS_SBT_SBT = "#{APPS_SBT}/sbt"

SBT_VERSION = "0.13.12"

SBT_REMOTE = "https://dl.bintray.com/sbt/native-packages/sbt/#{SBT_VERSION}"
SBT_REMOTE_FILE = "sbt-#{SBT_VERSION}.tgz"

APPS_SBT_AR = "#{APPS_SBT}/#{SBT_REMOTE_FILE}"
APPS_SBT_AR_EXTRACTED = "#{APPS_SBT}/sbt-#{SBT_VERSION}"

namespace :setup do

file APPS_SBT_AR do |f|
  directories f.name
  download SBT_REMOTE_FILE, SBT_REMOTE, APPS_SBT_AR
end

file APPS_SBT_AR_EXTRACTED => APPS_SBT_AR do |f|
  directories f.name
  extract APPS_SBT_AR, APPS_SBT, sbt: "sbt-#{SBT_VERSION}"
end

file APPS_SBT_SBT => APPS_SBT_AR_EXTRACTED do |f|
  directories f.name
  symlink APPS_SBT_AR_EXTRACTED, APPS_SBT_SBT
end

desc "Setup SBT to $HOME/Apps for Linux."
task :sbt => [APPS_SBT_SBT] do |t|
  update_path "sbt", "$HOME/Apps/SBT/sbt/bin"

  puts "SBT has been set up."
  puts "SBT is installed in: #{APPS_SBT}"
  puts
  puts "Run `source .bash_profile` to update PATH."
end

end
