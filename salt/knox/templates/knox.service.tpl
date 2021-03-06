[Install]
WantedBy=multi-user.target

[Unit]
Description={{ service_name }} service
After=network.target network.service

[Service]
Type=forking
ExecStart={{ knox_bin_dir }}/{{ service }}.sh start
ExecStop={{ knox_bin_dir }}/{{ service }}.sh stop
Restart=on-failure
TimeoutSec=5min
User={{ user }}
Group={{ group }}
