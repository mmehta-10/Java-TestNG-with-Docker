FROM maven:3.6.1-jdk-8-slim as build
COPY . .

#CMD ["mvn test"]

#FROM openjdk:8-jre-alpine
#COPY --from=build /app/target/spring-petclinic-1.5.1.jar /app
#CMD ["mvn test"]

RUN apt-get update && apt-get install -yq \
    firefox-esr \
#    chromium=62.0.3202.89-1~deb9u1 \
#    google-chrome-stable \
    xvfb \
    xsel \
    unzip \
    libgconf-2-4 \
    libncurses5 \
    libxml2-dev \
    libxslt-dev \
    libz-dev \
    xclip \
    libglib2.0-0 \
    libnss3 \
    libx11-6 \
    wget \
    gnupg

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
  && echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
  && apt-get update -qqy \
  && apt-get -qqy install \
    ${CHROME_VERSION:-google-chrome-stable} \
  && rm /etc/apt/sources.list.d/google-chrome.list \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# GeckoDriver v0.19.1
RUN wget -q "https://github.com/mozilla/geckodriver/releases/download/v0.26.0/geckodriver-v0.26.0-linux64.tar.gz" -O /tmp/geckodriver.tgz \
    && tar zxf /tmp/geckodriver.tgz -C /usr/bin/ \
    && rm /tmp/geckodriver.tgz

# chromeDriver v2.35
RUN wget -q "https://chromedriver.storage.googleapis.com/81.0.4044.20/chromedriver_linux64.zip" -O /tmp/chromedriver.zip \
    && unzip /tmp/chromedriver.zip -d /usr/bin/ \
    && rm /tmp/chromedriver.zip

# # xvfb - X server display
# ADD xvfb-chromium /usr/bin/xvfb-chromium
# RUN ln -s /usr/bin/xvfb-chromium /usr/bin/google-chrome \
#     && chmod 777 /usr/bin/xvfb-chromium

# Starting xfvb as a service
# ENV DISPLAY=:99
# ADD xvfb /etc/init.d/
# RUN chmod 755 /etc/init.d/xvfb

# setup Xvfb
RUN Xvfb :99 &
RUN export DISPLAY=:99

ENTRYPOINT ["mvn","test"]
