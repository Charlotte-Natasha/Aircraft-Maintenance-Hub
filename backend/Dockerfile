FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Create non-root user
RUN useradd -m flaskuser
USER flaskuser

EXPOSE 5000

CMD ["python", "run.py"]
