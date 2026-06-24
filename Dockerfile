FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt


RUN groupadd -g 1001 app && \
    useradd -r -u 1001 -g app -m -s /bin/bash app
    
COPY --chown=app:app . .

EXPOSE 3002
USER app
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "3002"]