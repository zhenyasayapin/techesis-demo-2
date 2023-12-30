# #!/usr/bin/bash
container_name=techesis-demo-2-container
image_name=techesis-demo-2-image

docker container stop $container_name
docker container remove $container_name

docker build -t $image_name . 

docker run -dp 127.0.0.1:3000:80 \
    --name $container_name \
    -v ./code:/var/www/html \
    -v ./logs:/var/log/nginx \
    $image_name 

docker ps
