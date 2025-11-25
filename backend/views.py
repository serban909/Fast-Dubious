from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.decorators import action
from django.shortcuts import get_object_or_404

from models import BadgeRequest, UserProfile
from serializers import BadgeRequestSerializer
from orchestrator import BadgeGenerationService
from ai_provider import BananaFaceAdapter

class BadgeViewSet(viewsets.ViewSet):
    """
    API ViewSet following REST principles.
    """
    
    def create(self, request):
        # 1. Input Validation
        user_id = request.data.get('user_id')
        modifiers = request.data.get('modifiers', {})
        
        user = get_object_or_404(UserProfile, id=user_id)
        
        # 2. Create Audit Record
        badge_req = BadgeRequest.objects.create(
            user=user,
            ai_prompt_modifiers=modifiers,
            status=BadgeRequest.Status.PROCESSING
        )

        # 3. Trigger Processing
        # CRITICAL: In a real enterprise app, pass 'badge_req.id' to Celery here.
        # For this example, we run synchronously.
        adapter = BananaFaceAdapter()
        service = BadgeGenerationService(ai_adapter=adapter)
        service.process_request(badge_req.id)

        # 4. Return Status
        badge_req.refresh_from_db()
        return Response({
            "request_id": badge_req.id,
            "status": badge_req.status,
            "badge_url": badge_req.final_badge.url if badge_req.final_badge else None
        }, status=status.HTTP_201_CREATED)

    @action(detail=True, methods=['get'])
    def status(self, request, pk=None):
        badge_req = get_object_or_404(BadgeRequest, pk=pk)
        return Response({
            "status": badge_req.status,
            "badge_url": badge_req.final_badge.url if badge_req.final_badge else None
        })