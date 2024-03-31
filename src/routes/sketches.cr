get "/" do
  svgs = SvgChock::Svg.all
  render "src/views/index.ecr", "src/views/layout.ecr"
end

get "/*svg" do |env|
  if svg = SvgChock::Svg.find(env.params.url["svg"])
    render "src/views/show.ecr", "src/views/layout.ecr"
  else
    render "src/views/404.ecr", "src/views/layout.ecr"
  end
end
