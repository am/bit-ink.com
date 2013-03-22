ignore /layout.html.haml/
ignore /\.git/
ignore /\.gitignore/
ignore /README/

layout 'layout.html.haml'

before 'index.html.haml' do
	def javascript_include_tag(file)
		"<script src='#{file}'></script>"
	end
	def stylesheet_link_tag(file)
		"<link href='#{file}' rel='stylesheet' />"
	end
end