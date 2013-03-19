ignore /layout.html.haml/
ignore /\.gitignore/
ignore /README/

layout 'layout.html.haml'

before 'index.html.haml' do
	def include_js(file)
		"<script src='#{file}'></script>"
	end
	def include_css(file)
		"<link href='#{file}' rel='stylesheet' />"
	end
end