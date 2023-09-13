# Builder Stage
FROM python:3.11-slim AS builder

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc

COPY src/requirements.txt .
RUN pip wheel --no-cache-dir --no-deps --wheel-dir /app/wheels -r requirements.txt

# Final Stage
FROM python:3.11-slim

WORKDIR /app

ENV HELLO_TO="Python"

COPY --from=builder /app/wheels /wheels
COPY ./src /app

RUN pip install --no-cache-dir /wheels/*
RUN pip install uvicorn

CMD uvicorn main:app --host 0.0.0.0 --port 80 --reload

EXPOSE 80