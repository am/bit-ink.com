ignore /layout.html.haml/
ignore /.gitignore/
ignore /README/

before 'index.html.haml' do
  layout 'layout.html.haml'
end