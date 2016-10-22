require "#{File.dirname __FILE__}/tools.rb"
require 'open3'

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


desc "Setup Android SDK and NDK in $HOME/Apps for Linux."
task :android => [APPS_ANDROID_SDK, APPS_ANDROID_NDK] do
  update_path "android", "$HOME/Apps/Android/sdk/tools:$HOME/Apps/Android/sdk/platform-tools:$HOME/Apps/Android/ndk"
  update_env "ANDROID_HOME", "$HOME/Apps/Android/sdk"
  update_env "NDK_BUILD", "$HOME/Apps/Android/ndk"

  puts "Android SDK and NDK have been set up."
  puts "The SDK location is at: #{APPS_ANDROID_SDK}"
  puts "The NDK location is at: #{APPS_ANDROID_NDK}"
  puts 
  puts "Run `source .bash_profile` to update PATH, ANDROID_HOME and NDK_BUILD."
  puts "You may also wish to update the sdk by running `android update sdk --no-ui`"
end

end
