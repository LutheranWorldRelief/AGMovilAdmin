working_directory "/app"

pid "/unicorn/pids/unicorn.pid"

stderr_path "/app/log/unicorn.stderr.log"
stdout_path "/app/log/unicorn.stdout.log"

listen "/unicorn/sockets/unicorn.sock"
listen 3000

worker_processes 2

timeout 30
