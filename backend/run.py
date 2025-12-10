import os
from app import create_app

app = create_app()

if __name__ == "__main__":
    # Read HTTP_PORT from environment, default to 5000 if not set
    http_port = int(os.getenv("HTTP_PORT", 5000))
    app.run(
        host="0.0.0.0",
        port=http_port
    )