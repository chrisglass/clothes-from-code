# base image
FROM python:3.7.2-stretch

# set working directory
WORKDIR /usr/src/app

# Downoad flask
RUN apt-get update && apt-get install python-flask3

# Download gecko driver
RUN wget https://github.com/mozilla/geckodriver/releases/download/geckodriver-v0.24.0-linux64.tar.gz && \
    tar -xvf geckodriver-v0.24.0-linux64.tar.gz && \
    mv geckodriver /bin/ && \
    rm geckodriver-v0.24.0-linux64.tar.gz

# add and install requirements
COPY ./requirements.txt /usr/src/app/requirements.txt
RUN pip install -r requirements.txt

# add entrypoint.sh
COPY ./entrypoint.sh /usr/src/app/entrypoint.sh
RUN chmod +x /usr/src/app/entrypoint.sh

# add app
COPY . /usr/src/app

# run server
CMD ["/usr/src/app/entrypoint.sh"]