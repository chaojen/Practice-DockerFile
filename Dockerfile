# Pull base image.
FROM python

# Set default WORKDIR in container
WORKDIR /app

# Update the repository
COPY . /app

# Install package requirements
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN uvicorn main:app --port 8000 --reload

# EXPOSE 80 port
EXPOSE 8000