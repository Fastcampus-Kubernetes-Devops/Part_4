FROM nginx:1.23
RUN echo "Demo Workflow" > /usr/share/nginx/html/index.html
RUN apt update && \
  apt upgrade -y
ENV AWS_ACCESS_KEY_ID=<AWS_ACCESS_KEY_ID>
ENV AWS_SECRET_ACCESS_KEY=<AWS_SECRET_ACCESS_KEY>
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]