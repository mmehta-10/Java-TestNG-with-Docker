FROM maven:3.6.1-jdk-8-slim as build
COPY . .
RUN mvn test
#CMD ["mvn test"]

#FROM openjdk:8-jre-alpine
#COPY --from=build /app/target/spring-petclinic-1.5.1.jar /app
#CMD ["mvn test"]

RUN apt-get update && apt-get install -yq \
    firefox \
#    chromium=62.0.3202.89-1~deb9u1 \
    google-chrome-stable \
    xvfb=2:1.19.2-1+deb9u2 \
    xsel=1.2.0-2+b1 \
    unzip=6.0-21 \
    libgconf2-4=3.2.6-4+b1 \
    libncurses5=6.0+20161126-1+deb9u2 \
    libxml2-dev=2.9.4+dfsg1-2.2+deb9u2 \
    libxslt-dev \
    libz-dev \
    xclip=0.12+svn84-4+b1

# GeckoDriver v0.19.1
RUN wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz" -O /tmp/geckodriver.tgz \
    && tar zxf /tmp/geckodriver.tgz -C /usr/bin/ \
    && rm /tmp/geckodriver.tgz

# chromeDriver v2.35
RUN wget -q "https://chromedriver.storage.googleapis.com/81.0.4044.20/chromedriver_linux64.zip" -O /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip -d /usr/bin/ \
    && rm /tmp/chromedriver.zip

# xvfb - X server display
ADD xvfb-chromium /usr/bin/xvfb-chromium
RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
    && chmod 777 /usr/bin/xvfb-chromium