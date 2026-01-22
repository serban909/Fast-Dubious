"""
URL Configuration for badges backend project.
"""
from django.contrib import admin
from django.urls import path, include
from django.shortcuts import redirect
from django.conf import settings
from django.conf.urls.static import static
from rest_framework.routers import DefaultRouter
from views import BadgeViewSet, login_view, signup_view, ProfileViewSet, VehicleViewSet, InsurancePolicyViewSet

router = DefaultRouter()
router.register(r'badges', BadgeViewSet, basename='badge')
router.register(r'profile', ProfileViewSet, basename='profile')
router.register(r'vehicles', VehicleViewSet, basename='vehicle')
router.register(r'insurance', InsurancePolicyViewSet, basename='insurance')

urlpatterns = [
    path('', lambda request: redirect('admin/', permanent=False)), # Redirect root to admin
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('api/auth/login/', login_view),
    path('api/auth/signup/', signup_view),
]

# Serve media files in development
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
