threads_count = ENV.fetch('RAILS_MAX_THREADS') { 5 }.to_i
threads threads_count, threads_count
environment 'production'
plugin :tmp_restart

pidfile 'tmp/pids/puma.pid'
state_path 'tmp/pids/puma.state'
bind 'unix://tmp/sockets/puma.sock'
activate_control_app 'unix://tmp/sockets/pumactl.sock'
stdout_redirect 'log/puma.log', 'log/puma_err.log', true
tag 'whbab'
