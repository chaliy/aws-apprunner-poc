from fastapi import APIRouter
from foo.api import version

api_router = APIRouter()

api_router.include_router(version.router, tags=["version"])
