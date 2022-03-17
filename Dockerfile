FROM nginx:1.15.8-alpine
COPY ./nginx.conf /etc/nginx/nginx.conf

COPY ./index.html /usr/share/nginx/html

# docker build . -t fforfrodo/helloworld

# docker push fforfrodo/helloworld

# docker run -it --rm -p 8080:80 fforfrodo/helloworld:latest