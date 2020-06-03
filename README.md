# GUÍA DE INSTALACIÓN CACAO MOVIL
INSTALACIÓN DE CACAO MÓVIL

1. Clonar proyecto /[RUTA DEL PROYECTO]

2. Ejecutar el comando export RAILS_ENV=production

3. Se crean los directorios de Unicorn
  > mkdir pids    
  > mkdir sockets

4. Se crea el archivo de configuración
  > nano config/unicorn_cacaomovil.rb

Dentro de la configuración colocaremos
  >
    working_directory "/[RUTA DEL PROYECTO]"
    
    pid "/[RUTA DEL PROYECTO]/pids/unicorn.pid"
    
    stderr_path "/[RUTA DEL PROYECTO]/log/unicorn.log"
    stdout_path "/[RUTA DEL PROYECTO]/log/unicorn.log"
    
    listen "/[RUTA DEL PROYECTO]/sockets/unicorn.cacao.sock"
    
    worker_processes 2
    
    timeout 30


5. Modificamos la configuración de Nginx
  >
    upstream cacaomovil {
        server unix:/[RUTA DEL PROYECTO]/sockets/unicorn.cacao.sock fail_timeout=0;
    }

    server {
        listen 80;
        server_name "DOMINIO A ELEGIR";

        root /[RUTA DEL PROYECTO]/public;

        try_files $uri/index.html $uri @cacaomovil;

        location @cacaomovil {
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header Host $http_host;
            proxy_redirect off;
            proxy_pass http://app;
        }

        error_page 500 502 503 504 /500.html;
        client_max_body_size 4G;
        keepalive_timeout 10;
    }

6. Reiniciamos Nginx
