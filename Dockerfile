FROM maven:3.8-jdk-8-openj9

WORKDIR /app

COPY ./ ./

RUN mvn test-compile

RUN mvn dependency:copy-dependencies

RUN apt-get update && apt-get install -y nginx

COPY ./server/default.conf /etc/nginx/conf.d/

EXPOSE 3000

CMD ["java", "-cp", "target/test-classes:target/classes:target/dependency/*", "Main"]
