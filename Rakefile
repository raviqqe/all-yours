rule '.html' => '.elm' do |t|
  sh "elm-make --yes --warn --output #{t.name} #{t.source}"
end

task :mantest do
  sh 'python3 -m http.server -- 8888'
end

task :default => 'Main.html'

task :clean do
  sh 'git clean -dfx'
end
