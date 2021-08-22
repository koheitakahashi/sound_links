app_root = File.expand_path("..", __dir__)
bind "unix://#{app_root}/tmp/sockets/puma.sock"
