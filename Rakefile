MAIN_HTML = 'Main.html'


file MAIN_HTML => Dir.glob('src/**/*.elm') do |t|
  sh "elm-make --yes --warn --output #{t.name} src/Main.elm"
end


task :mantest do
  sh 'python3 -m http.server -- 8888'
end


task :default => MAIN_HTML


task :clean do
  rm_f MAIN_HTML
end


task :clobber do
  sh 'git clean -dfx'
end
