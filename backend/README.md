# Badges Backend - Django Project

Enterprise badge generation system with AI-powered face modification.

## Features

- **User Profile Management**: Store employee data with profile photos
- **AI Face Modification**: Integrate with Banana/Stable Diffusion API
- **Badge Composition**: Automated badge creation using Pillow
- **REST API**: Full RESTful API with Django REST Framework
- **Audit Trail**: Track all badge generation requests and artifacts

## Project Structure

```
backend/
├── manage.py              # Django management script
├── settings.py            # Django settings
├── urls.py                # URL routing
├── models.py              # Database models (UserProfile, BadgeRequest)
├── views.py               # REST API views
├── serializers.py         # DRF serializers
├── orchestrator.py        # Badge generation orchestration
├── ai_provider.py         # AI service adapters
├── compositor.py          # Badge composition with Pillow
├── admin.py               # Django admin configuration
├── requirements.txt       # Python dependencies
├── templates/             # Badge templates (PNG files)
├── assets/                # Fonts and static assets
└── media/                 # User uploads (created automatically)
```

## Setup Instructions

### 1. Create Virtual Environment

```powershell
# Navigate to the backend directory
cd "c:\Users\uiv21850\OneDrive - Vitesco Technologies\Desktop\badges\badges\backend"

# Create virtual environment
python -m venv venv

# Activate virtual environment
.\venv\Scripts\Activate.ps1
```

If you get an execution policy error, run:
```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### 2. Install Dependencies

```powershell
pip install -r requirements.txt
```

### 3. Configure Environment Variables (Optional)

```powershell
# Copy example environment file
copy .env.example .env

# Edit .env and add your API keys
notepad .env
```

### 4. Run Database Migrations

```powershell
python manage.py makemigrations
python manage.py migrate
```

### 5. Create Superuser (for Admin Panel)

```powershell
python manage.py createsuperuser
```

Follow the prompts to create an admin account.

### 6. Run Development Server

```powershell
python manage.py runserver
```

The server will start at `http://127.0.0.1:8000/`

## API Endpoints

### Create Badge Request
```
POST /api/badges/
Content-Type: application/json

{
  "user_id": 1,
  "modifiers": {
    "mustache": true,
    "glasses": true
  }
}
```

### Check Badge Status
```
GET /api/badges/{request_id}/status/
```

### Admin Panel
```
http://127.0.0.1:8000/admin/
```

## Database

**Development**: Uses SQLite (no setup needed)

**Production**: Switch to MySQL by uncommenting the MySQL configuration in `settings.py` and installing MySQL:

```powershell
# Install MySQL connector
pip install mysqlclient
```

## Testing the Badge Compositor

To test the badge compositor independently:

```powershell
python comptest.py
```

This will create a sample badge using the test data.

## Troubleshooting

### Import Errors
Make sure you're in the virtual environment:
```powershell
.\venv\Scripts\Activate.ps1
```

### Missing Pillow
```powershell
pip install Pillow
```

### Font Issues
The compositor will fall back to default fonts if custom fonts are missing. Place `.ttf` files in the `assets/` directory.

## Next Steps

1. Add actual user profiles via admin panel or API
2. Configure AI provider credentials in `.env`
3. Test badge generation workflow
4. Set up Celery for async processing (recommended for production)

## Production Considerations

- Set `DEBUG = False` in settings.py
- Use proper `SECRET_KEY` (generate with `django.core.management.utils.get_random_secret_key()`)
- Configure ALLOWED_HOSTS properly
- Use MySQL or PostgreSQL instead of SQLite
- Set up Celery for background processing
- Use proper file storage (S3, Azure Blob, etc.)
- Add authentication/authorization
