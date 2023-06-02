# Pull base image.
FROM python

# Set default WORKDIR in container
WORKDIR /app

# Update the repository
COPY . /app

# Install package requirements
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

# EXPOSE 80 port
EXPOSE 80

ENTRYPOINT ["/app/docker-entrypoint.sh"]