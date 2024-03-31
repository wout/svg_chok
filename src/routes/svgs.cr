get "/svgs/*svg" do |env|
  send_file env, File.join("./svgs", env.params.url["svg"])
end
