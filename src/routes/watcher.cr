SOCKETS = [] of HTTP::WebSocket

ws "/watcher" do |socket|
  SOCKETS << socket

  watcher = SvgChok::Watcher.new

  spawn do
    while !socket.closed?
      socket.send({files: watcher.changes}.to_json)

      sleep 1
    end
  end

  socket.on_close do
    SOCKETS.delete socket
  end

  Fiber.yield
end
