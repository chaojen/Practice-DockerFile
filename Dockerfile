# Pull base image.
FROM nginx

# Set default WORKDIR in container
WORKDIR /app

# Update the repository
COPY . /app

# Install python 3.7
RUN apt-get update -y && \
    apt-get install -y python3.7 python3-pip python3.7-dev

# Install package requirements
COPY requirements.txt requirements.txt
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

# EXPOSE 80 port
EXPOSE 80

ENTRYPOINT ["/app/docker-entrypoint.sh"]