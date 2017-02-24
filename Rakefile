rule '.html' => '.elm' do |t|
  sh "elm-make --yes --output #{t.name} #{t.source}"
end

task :default => 'Main.html'

task :clean do
  sh 'git clean -dfx'
end
