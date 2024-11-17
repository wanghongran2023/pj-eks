FROM python:3.12-slim
WORKDIR /app

COPY ./analytics/requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ENV DB_USERNAME=myuser
ENV DB_PASSWORD=mypassword

COPY ./analytics/config.py .
COPY ./analytics/app.py .

EXPOSE 5153

CMD ["python", "app.py"]
