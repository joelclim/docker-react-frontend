FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# AWS will fail on named builders. Use this instead:
#   FROM node:alpine
#   ...
#   COPY --from=0 /app/build /usr/share/ngix/html
#
# https://hub.docker.com/_/nginx
#    a simple Dockerfile can be used to generate a new image that includes the necessary content (which is a much cleaner solution than the bind mount above):
#   FROM nginx
#   COPY static-html-directory /usr/share/nginx/html
COPY --from=builder /app/build /usr/share/nginx/html