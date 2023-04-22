FROM node As build-stage 

WORKDIR /app

COPY . .

RUN npm install && npm run build

FROM nginx:alpine As deploy-stage
WORKDIR /usr/share/nginx/html

RUN rm -rf ./*


COPY --from=build-stage /app/build .


ENTRYPOINT [ "nginx","-g", "daemon off;"]