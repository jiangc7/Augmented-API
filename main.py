from fastapi import FastAPI, Depends
from fastapi.responses import JSONResponse
from typing import List
import asyncpg
from fastapi.middleware.cors import CORSMiddleware
import os
from dotenv import load_dotenv
from pathlib import Path
# import connect

from decouple import config

# app = FastAPI()

app = FastAPI(openapi_url="/api/openapi.json")

def setup_cors(app: FastAPI):
    app.add_middleware(
        CORSMiddleware,
        # Allow access from localhost, another IPs
        allow_origin_regex=r"https?://(localhost|192\.168\.1\.\d+|192\.168\.20\.\d+|10\.22\.0\.\d+):\d+",
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
        max_age=86400,
    )
   
setup_cors(app)




load_dotenv('.env')
DATABASE_URL = config('DATABASE_URL')
print(DATABASE_URL)
# print('env +++++++++' + os.environ.get('DATABASE_URL'))



async def get_database_connection():
    conn = await asyncpg.connect(DATABASE_URL)
    return conn

@app.get("/")
async def read_root():
    return {"Hello": "postgresql"}

@app.get("/paddock")
async def get_paddock(conn = Depends(get_database_connection)):
    result = await conn.fetch("SELECT paddockid,size,soiltemp, soilmoisture,dryMatter, description ,icon , img, ontap, to_jsonb(boundaryvertices) as boundaryvertices, distance  FROM public.paddock")
    key_value_data = []
    key = ["paddockid","size","soiltemp", "soilmoisture","dryMatter", "description" ,"icon" , "img", "ontap", "boundaryvertices", "distance"]
    for row in result:
          row1 = dict(zip(key,row))
          key_value_data.append(row1)

    return key_value_data

@app.get("/article")
async def get_article(conn = Depends(get_database_connection)):
    result = await conn.fetch("SELECT *  FROM public.article")
    key_value_data = []
    key = ["articleid","name","paddockid", "latitude","longtitude","distance", "description" ,"icon" , "img", "uri", "scale", "position", "items"]
    for row in result:
          row1 = dict(zip(key,row))
          key_value_data.append(row1)

    return key_value_data

# articleid SERIAL PRIMARY KEY,
#   name varchar(45) NOT NULL,
#   paddockid int REFERENCES paddock(paddockid),
#   latitude double precision,
#   longtitude double precision,
#   distance double precision,
#   description varchar(200),
#   icon varchar(45),
#   img varchar(45),
#   uri varchar(45),
#   scale jsonb,
#   position jsonb,
#   items jsonb
# @app.post("/users")
# async def create_user(name: str, email: str, conn = Depends(get_database_connection)):
#     result = await conn.execute("INSERT INTO users (name, email) VALUES ($1, $2)", name, email)
#     return JSONResponse(content={"message": "User created successfully"})