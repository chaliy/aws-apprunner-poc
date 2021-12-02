from fastapi import FastAPI
from foo.api.api import api_router

app = FastAPI(
    title="Foo API",
    version="1.0.0",
    openapi_url=f"/api/openapi.json",
)

app.include_router(api_router, prefix="/api")

print("Check me...")