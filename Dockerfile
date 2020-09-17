FROM node:14.10.1-slim
WORKDIR /usr/src/app

RUN npm install -g npm
RUN npm install -g create-react-app
