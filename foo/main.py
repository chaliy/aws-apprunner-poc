from fastapi import FastAPI
from foo.api.api import api_router

import boto3

ssm = boto3.client("ssm")

secret = ssm.get_parameter(
    Name="recovery-key",
    WithDecryption=True
)

print(f"Secret: {secret}")

app = FastAPI(
    title="Foo API",
    version="1.0.0",
    openapi_url=f"/api/openapi.json",
)

app.include_router(api_router, prefix="/api")
