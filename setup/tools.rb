APPS = "#{ENV['HOME']}/Apps"

def download file, from, to
  sh 'wget', '-c', '-O', "#{to}.part", "#{from}/#{file}"
  mv "#{to}.part", to
end

def directories file
  dirname = File.dirname(file)

  if not File.exist? dirname
    sh 'mkdir', '-p', File.dirname(file)
  end
end

def extract file, where, root_rename = nil
  extname = File.extname(file)

  if ".zip" == extname
    unzip file, where
  elsif ".tgz" == extname
    untar file, where, root_rename
  else
    raise "Don't know how to extract files with extension #{extname}; at '#{file}'"
  end
end

def unzip file, where
  sh 'unzip', file, '-d', where
end

def untar file, where, root_rename = nil
  args = ['-C', where]

  if root_rename
    rename = root_rename.first
    args << '--transform'
    args << "s/^#{rename.first}/#{rename.last}/"
  end

  args << '-xf'
  args << file

  sh 'tar', *args
end

def symlink target, name
  sh 'ln', '-sb', target, name
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

def update_env env, source, local = true
  files = FileList["#{ENV['HOME']}/.env.d/*.env"].sort
  names = files.map {|f| /^[0-9]+-([a-z0-9\-_]+)\..*/i.match(File.basename(f))[1] }

  return if names.index env
  
  last = files.last
  last_id = File.basename(last).split('-').first.to_i
  new_id = last_id + 1

  envfile = "#{File.dirname(last)}/#{new_id.to_s.rjust(2, '0')}-#{env}#{local ? '.local' : ''}.env"

  File.open envfile, 'w+' do |f|
    f.write "export #{env}=\"#{source}\""
  end
  
  puts "update_env #{envfile}\n #{env}=\"#{source}\""
end
