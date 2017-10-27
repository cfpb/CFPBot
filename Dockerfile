FROM node:latest
ADD . /app
WORKDIR /app
ENTRYPOINT ["npm", "start"]
