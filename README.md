# Aircraft Maintenance Management System

A full-stack Docker application for managing aircraft maintenance records, parts inventory, and maintenance status tracking.

## 🏗️ Architecture

- **Backend**: Python Flask REST API (port 8000)
- **Frontend**: React + Vite (port 3000)
- **Database**: PostgreSQL (port 5432)
- **Orchestration**: Docker Compose

## 🚀 Quick Start

### Prerequisites

- Docker & Docker Compose installed

### Run the Application

```bash
docker-compose up --build
```

The application will be available at `http://localhost:3000`

### Initial Setup

Environment variables are configured via `.env` file in the `backend/` directory. Update as needed:

```env
DB_NAME=aircraft_db
DB_USER=postgres
DB_PASSWORD=your_password
HTTP_PORT=8000
```

## 📁 Project Structure

```
├── backend/          # Flask API
│   ├── app/         # Application code (routes, models, config)
│   ├── db/          # Database initialization scripts
│   └── requirements.txt
├── frontend/        # React + Vite UI
│   ├── src/
│   │   ├── components/  # UI components (Aircraft, Maintenance, Parts, etc.)
│   │   └── styles/
│   └── nginx.conf   # Production web server config
├── scripts/         # Deployment scripts
└── docker-compose.yml
```

## 🛠️ Development

### Backend

```bash
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
python run.py
```

### Frontend

```bash
cd frontend
npm install
npm run dev
```

## 📦 Key Dependencies

**Backend:**

- Flask - Web framework
- Flask-Cors - Cross-origin support
- PostgreSQL driver
- python-dotenv - Environment management

**Frontend:**

- React 18
- Vite - Build tool
- ESLint - Code quality

## 🔒 Security Features

- No privilege escalation in containers
- Dropped all container capabilities
- Health checks for all services
- PostgreSQL connection pooling
