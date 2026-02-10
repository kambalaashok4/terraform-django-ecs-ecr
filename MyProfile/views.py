
from django.shortcuts import render

def linkedin_view(request):
    context = {
        "linkedin_url": "https://www.linkedin.com/in/"
    }
    return render(request, "profile/linkedin.html", context)

