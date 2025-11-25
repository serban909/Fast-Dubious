# Django Setup - Quick Start Guide

## ✅ Setup Complete!

Your Django project is now fully configured and running!

## Current Status

- ✅ Django 4.2.26 installed
- ✅ Database migrated (SQLite)
- ✅ Admin user created
- ✅ Development server running at **http://127.0.0.1:8000/**

## Login Credentials

**Admin Panel**: http://127.0.0.1:8000/admin/
- **Username**: `admin`
- **Password**: `admin123`

## API Endpoints

- **Badge API**: http://127.0.0.1:8000/api/badges/
- **Admin Panel**: http://127.0.0.1:8000/admin/

## Project Structure

```
backend/
├── manage.py              ✅ Django management
├── settings.py            ✅ Complete Django settings (SQLite for dev)
├── urls.py                ✅ URL routing
├── models.py              ✅ UserProfile & BadgeRequest models
├── views.py               ✅ REST API views
├── serializers.py         ✅ DRF serializers
├── orchestrator.py        ✅ Badge generation service
├── ai_provider.py         ✅ AI service adapter
├── compositor.py          ✅ Badge composition (updated layout)
├── admin.py               ✅ Admin configuration
├── requirements.txt       ✅ Dependencies list
├── db.sqlite3             ✅ Database (auto-created)
└── README.md              ✅ Full documentation
```

## Common Commands

### Start Server
```powershell
C:/LegacyApp/Python311/python.exe manage.py runserver
```

### Stop Server
Press `CTRL+C` in the terminal

### Create Superuser
```powershell
C:/LegacyApp/Python311/python.exe manage.py createsuperuser
```

### Make Migrations (after model changes)
```powershell
C:/LegacyApp/Python311/python.exe manage.py makemigrations
C:/LegacyApp/Python311/python.exe manage.py migrate
```

### Django Shell (for testing)
```powershell
C:/LegacyApp/Python311/python.exe manage.py shell
```

## Next Steps

1. **Add Users**: Go to admin panel and create UserProfile entries
2. **Upload Photos**: Add profile photos for users
3. **Test Badge API**: Use the /api/badges/ endpoint
4. **Configure AI**: Set up BANANA_API_KEY in .env file

## Testing the Badge Compositor

To test badge generation without the full API:

```powershell
C:/LegacyApp/Python311/python.exe comptest.py
```

This creates a sample badge using test data.

## Troubleshooting

### Server Not Starting?
- Check if port 8000 is already in use
- Try: `C:/LegacyApp/Python311/python.exe manage.py runserver 8080`

### Import Errors?
- All imports are now absolute (not relative)
- Models have `app_label = 'badges'`

### Database Issues?
- Delete `db.sqlite3` and re-run `migrate`

## File Changes Made

1. **settings.py**: Complete Django configuration
2. **models.py**: Added `app_label = 'badges'` to Meta classes
3. **views.py**: Fixed imports to absolute
4. **serializers.py**: Created DRF serializers
5. **urls.py**: Created URL routing with REST router
6. **admin.py**: Registered models in admin
7. **compositor.py**: Updated draw.text layout from comptest.py
8. **requirements.txt**: Listed all dependencies
9. **README.md**: Full project documentation

## Production Notes

- Currently using **SQLite** for easy development
- To use **MySQL**: Uncomment MySQL config in `settings.py`
- Change `DEBUG = False` and set proper `SECRET_KEY`
- Configure `ALLOWED_HOSTS`
- Set up proper environment variables

---

**Server is running at**: http://127.0.0.1:8000/
**Admin panel**: http://127.0.0.1:8000/admin/ (admin/admin123)
