from typing import Any

from fastapi import APIRouter

router = APIRouter()


@router.get("/version")
async def version() -> Any:
    return {"version": "green"}
