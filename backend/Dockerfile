FROM python:3.12-slim

WORKDIR /app

# Copy dependency file
COPY requirements.txt .

# Install Python dependencies (including uvicorn)
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy your backend code
COPY . .

# Expose API port
ENV FLASK_APP=run.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8000

# Start the backend
CMD ["python", "run.py"]

