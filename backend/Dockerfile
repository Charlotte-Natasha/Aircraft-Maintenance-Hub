# =========================
# Stage 1: Build dependencies (optional caching stage)
# =========================
FROM python:3.12-slim AS builder

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system packages needed for psycopg2
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements for caching
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install --prefix=/install -r requirements.txt


# =========================
# Stage 2: Minimal runtime
# =========================
FROM python:3.12-slim

# System packages for psycopg2
RUN apt-get update && apt-get install -y libpq-dev gcc \
    && rm -rf /var/lib/apt/lists/*

# Create non-root user
RUN useradd --create-home --shell /bin/bash appuser

WORKDIR /app

# Copy application code
COPY . .

# Install Python packages inside runtime stage
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Permissions for non-root user
RUN chown -R appuser:appuser /app
USER appuser

# Expose HTTP port
ENV HTTP_PORT=8000
EXPOSE 8000

CMD ["python", "run.py"]
