# Build React App
FROM node:14.15.0 as builder
RUN mkdir -p /project/hosting-react
WORKDIR /project/hosting-react
ENV PATH /project/hosting-react/node_modules/.bin:$PATH
COPY ./my-app/package.json /project/hosting-react/package.json
RUN npm install --silent
RUN npm install react-scripts@3.4.1 -g --silent
COPY ./my-app /project/hosting-react
RUN npm run build


# Production Environment
FROM nginx:1.19.3-alpine
ENV PUBLIC_URL service.salt-mine.io
COPY --from=builder /project/hosting-react/build /usr/share/nginx/html
EXPOSE 80
EXPOSE 443
CMD ["nginx", "-g", "daemon off;"]
