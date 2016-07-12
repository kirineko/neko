server {
    charset utf-8;
    client_max_body_size 128M;

    listen 80; 

    server_name yii2.app;
    root        /home/vagrant/projects/yii2/web;
    index       index.php;

    access_log  off;
    error_log   /home/vagrant/logs/nginx.yii.error.log error;

    location / {
        try_files $uri $uri/ /index.php$is_args$args;
    }


    location ~ ^/assets/.*\.php$ {
        deny all;
    }

    location ~ \.php$ {
        fastcgi_split_path_info ^(.+\.php)(/.+)$;
        fastcgi_pass unix:/var/run/php/php7.0-fpm.sock;
        fastcgi_index index.php;
        include fastcgi_params;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;

        fastcgi_intercept_errors off;
        fastcgi_buffer_size 16k;
        fastcgi_buffers 4 16k;
        fastcgi_connect_timeout 300;
        fastcgi_send_timeout 300;
        fastcgi_read_timeout 300;
    }

    location ~* /\. {
        deny all;
    }
}