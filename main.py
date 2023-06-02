# -*- coding: utf-8 -*-
from fastapi import FastAPI
from fastapi.responses import HTMLResponse

app = FastAPI()

@app.get("/")
def read_root():
    return "hello inbody"

@app.get("/bmi", response_class=HTMLResponse)
def cal_bmi(height: int, weight: int):
    # BMI < 18.5：體重過輕
    # 18.5 <= BMI < 25：正常體重
    # 25 <= BMI < 30：超重
    # BMI >= 30：肥胖
    bmi = weight / ((height / 100) ** 2)
    
    description = ""
    if bmi >= 30:
        description = "肥胖"
    elif bmi >= 25:
        description = "超重"
    elif bmi >= 18.5:
        description = "正常體重"
    else: 
        description = "體重過輕"

    return f"你的 BMI 指數是:{bmi}({description})".encode("utf-8")
