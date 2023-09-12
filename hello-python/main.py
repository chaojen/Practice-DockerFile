# -*- coding: utf-8 -*-
from fastapi import FastAPI
import os

app = FastAPI()
hello_to = os.getenv(key="HELLO_TO", default="Python")

@app.get("/")
def read_root():
    return "hello, " + hello_to