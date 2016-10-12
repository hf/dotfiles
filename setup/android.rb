require 'open3'

APPS = "#{ENV['HOME']}/Apps"
APPS_ANDROID = "#{APPS}/Android"

ANDROID_SDK_REMOTE = 'https://dl.google.com/android/'
ANDROID_NDK_REMOTE = 'https://dl.google.com/android/repository/'

ANDROID_SDK_LINUX_AR = 'android-sdk_r24.4.1-linux.tgz'
ANDROID_NDK_LINUX_AR = 'android-ndk-r13-linux-x86_64.zip'

APPS_ANDROID_SDK_AR_EXTRACTED = "#{APPS_ANDROID}/android-sdk-linux"
APPS_ANDROID_NDK_AR_EXTRACTED = "#{APPS_ANDROID}/android-ndk-r13"

APPS_ANDROID_SDK_AR = "#{APPS_ANDROID}/#{ANDROID_SDK_LINUX_AR}"
APPS_ANDROID_NDK_AR = "#{APPS_ANDROID}/#{ANDROID_NDK_LINUX_AR}"


APPS_ANDROID_SDK = "#{APPS_ANDROID}/sdk"
APPS_ANDROID_NDK = "#{APPS_ANDROID}/ndk"

namespace :setup do

def download file, from, to
  sh 'wget', '-O', to, "#{from}/#{file}"
end

def directories file
  dirname = File.dirname(file)

  if not File.exist? dirname
    sh 'mkdir', '-p', File.dirname(file)
  end
end

def extract file, where
  extname = File.extname(file)

  if ".zip" == extname
    unzip file, where
  elsif ".tgz" == extname
    untar file, where
  else
    raise "Don't know how to extract files with extension #{extname}; at '#{file}'"
  end
end

def unzip file, where
  sh 'unzip', file, '-d', where
end

def untar file, where
  sh 'tar', '-C', where, '-xf', file
end

def symlink target, name
  sh 'ln', '-sb', target, name
end

file APPS_ANDROID_SDK_AR do |f|
  directories f.name
  download ANDROID_SDK_LINUX_AR, ANDROID_SDK_REMOTE, f.name
end

file APPS_ANDROID_NDK_AR do |f|
  directories f.name
  download ANDROID_NDK_LINUX_AR, ANDROID_NDK_REMOTE, f.name
end

file APPS_ANDROID_SDK_AR_EXTRACTED => APPS_ANDROID_SDK_AR do |f|
  if not File.exist? f.name
    directories f.name
    extract APPS_ANDROID_SDK_AR, APPS_ANDROID
  end
end

file APPS_ANDROID_NDK_AR_EXTRACTED => APPS_ANDROID_NDK_AR do |f|
  if not File.exist? f.name 
    directories f.name
    extract APPS_ANDROID_NDK_AR, APPS_ANDROID
  end
end

file APPS_ANDROID_SDK => APPS_ANDROID_SDK_AR_EXTRACTED do |f|
  directories f.name
  symlink APPS_ANDROID_SDK_AR_EXTRACTED, APPS_ANDROID_SDK
end

file APPS_ANDROID_NDK => APPS_ANDROID_NDK_AR_EXTRACTED do |f|
  directories f.name
  symlink APPS_ANDROID_NDK_AR_EXTRACTED, APPS_ANDROID_NDK
end

def update_path name, path, local = true
  files = FileList["#{ENV['HOME']}/.path.d/*.path"].sort
  names = files.map {|f| /^[0-9]+-([a-z0-9\-_]+)\..*/i.match(File.basename(f))[1] }
  
  return if names.index name

  last = files.last

  last_id = File.basename(last).split('-').first.to_i
  new_id = last_id + 1

  pathfile = "#{File.dirname(last)}/#{new_id.to_s.rjust(2, '0')}-#{name}#{local ? '.local' : ''}.path"

  File.open pathfile, 'w+' do |f|
    f.write path
  end
  
  puts "update_path #{pathfile}\n #{path}"
end

desc "Setup Android SDK and NDK in $HOME/Apps for Linux."
task :android => [APPS_ANDROID_SDK, APPS_ANDROID_NDK] do
  update_path "android", "$HOME/Apps/Android/sdk/tools:$HOME/Apps/Android/sdk/platform-tools:$HOME/Apps/Android/ndk"
end

end
