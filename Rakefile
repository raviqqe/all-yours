MAIN_HTML = 'Main.html'


rule '.html' => '.elm' do |t|
  sh "elm-make --yes --warn --output #{t.name} #{t.source}"
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
