FROM --platform=linux/amd64  python:3.12-slim
WORKDIR /app

COPY ./analytics/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

COPY ./analytics/config.py .
COPY ./analytics/app.py .

EXPOSE 5153

CMD ["cat", "app.py"]
