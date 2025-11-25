# Enterprise: Use MySQL as the durable data store
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'enterprise_badges',
        'USER': 'db_user',
        'PASSWORD': 'secure_password',
        'HOST': 'localhost', # or RDS endpoint
        'PORT': '3306',
    }
}

# File Storage
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'