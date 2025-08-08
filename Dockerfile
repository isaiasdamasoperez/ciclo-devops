FROM python:3.12-slim

# Prevents Python from writing .pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install build deps only if needed (Flask doesn't need system deps)
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000
# Use gunicorn in prod for robustness (optional). Falling back to flask.
# If you want gunicorn, uncomment next line and add it to requirements.
# CMD ["gunicorn", "-w", "2", "-b", "0.0.0.0:5000", "app:app"]
CMD ["python", "app.py"]
