davmail_run_opts := \
	-v /var/log/davmail:/srv/davmail/log \
	-p 1080:1080 \
	-p 1143:1143 \
	-p 1389:1389 \
	-p 1025:1025

nginx_run_opts := \
	-v /var/log/nginx:/srv/ceh/log \
	-p 80:80 \
	-p 443:443
