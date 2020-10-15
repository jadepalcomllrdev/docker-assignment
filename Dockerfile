#STAGE 1 production build
FROM node:12-alpine AS build
RUN mkdir -p /app
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ /app
RUN npm run build --prod

#STAGE 2
FROM nginx:1.19.2-alpine as prod-stage
COPY --from=build /app/dist/docker-assignment /usr/share/nginx/html
EXPOSE 4200
CMD ["nginx", "-g", "daemon off;"]