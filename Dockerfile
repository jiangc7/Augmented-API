FROM python:3.10
RUN pip3 install fastapi uvicorn asyncpg python-dotenv python-decouple
COPY . /app
WORKDIR /app
CMD [ "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000" ]