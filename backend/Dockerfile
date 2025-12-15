FROM python:3.12-slim

WORKDIR /app

# Create non-root user 
RUN useradd -m charlotte

# Copy dependency file
COPY requirements.txt .

# Install Python dependencies (including uvicorn)
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy your backend code
COPY . .

# Give charlotte ownership of the app folder
RUN chown -R charlotte:charlotte /app

# Switch to non-root user
USER charlotte

# Expose API port
ENV FLASK_APP=run.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8000

# Start the backend
CMD ["python", "run.py"]

