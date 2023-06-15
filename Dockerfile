FROM alpine as builder

ARG API_ENDPOINT

WORKDIR /src
COPY index.html .
RUN sed -i "s#api.holaplex.com#$API_ENDPOINT#g" index.html

FROM nginxinc/nginx-unprivileged:stable-bullseye

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /src/index.html /usr/share/nginx/html/
COPY static /usr/share/nginx/html/static/
