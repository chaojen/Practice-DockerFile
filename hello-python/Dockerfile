FROM python

ENV HELLO_TO="Python"

WORKDIR /app

COPY . /app

RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pip install uvicorn

CMD uvicorn main:app --host 0.0.0.0 --port 80 --reload

EXPOSE 80