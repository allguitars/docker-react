# 透過 tag 的方式 來區分不同 stage
FROM node:alpine as builder
WORKDIR /app
COPY package.json .
RUN yarn install
COPY . .
RUN yarn build

# FROM 指令隱含區隔不同 stage
FROM nginx
EXPOSE 80
# --from: copy files from the builder phase
COPY --from=builder /app/build /usr/share/nginx/html