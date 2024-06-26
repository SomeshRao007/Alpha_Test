FROM node:20
WORKDIR /usr/src/app
COPY package.json yarn.lock ./
RUN yarn install
COPY . .
RUN yarn build
EXPOSE 1337
CMD ["yarn", "start"]


#FROM node:20-alpine AS build

#WORKDIR /usr/src/app
#COPY package.json yarn.lock ./
#RUN yarn install
#COPY . .
#RUN yarn build

#FROM node:20-alpine 

#WORKDIR /usr/src/app 
#COPY --from=build /usr/src/app /usr/src/app
#EXPOSE 1337
#CMD ["yarn", "start"]

