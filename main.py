from pathlib import Path
from uuid import uuid4

from fastapi import FastAPI, File, HTTPException, UploadFile
from fastapi.middleware.cors import CORSMiddleware
from pydantic import BaseModel

app = FastAPI(
    title="AI Novel Reader API",
    version="0.1.0",
    description="Development starter API. Add auth, persistent DB, storage, and scanning before production.",
)

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Development only. Restrict this before production.
    allow_credentials=False,
    allow_methods=["*"],
    allow_headers=["*"],
)

UPLOAD_DIR = Path("local_uploads")
UPLOAD_DIR.mkdir(exist_ok=True)
MAX_UPLOAD_BYTES = 25 * 1024 * 1024

# Demo data only; replaced by PostgreSQL models in the next milestone.
NOVELS = [
    {
        "id": "demo-001",
        "title": "The Ashen Crown",
        "author": "Demo Author",
        "description": "A sample fantasy novel used to preview the app.",
        "languages": ["en"],
        "chapter_count": 12,
        "visibility": "public",
    }
]


class NovelCreate(BaseModel):
    title: str
    author: str = "Unknown"
    description: str = ""
    language: str = "en"


@app.get("/health")
def health():
    return {"status": "ok", "service": "ai-novel-reader-api", "version": "0.1.0"}


@app.get("/api/v1/novels")
def list_novels():
    return {"items": NOVELS, "count": len(NOVELS)}


@app.post("/api/v1/novels")
def create_novel(payload: NovelCreate):
    title = payload.title.strip()
    if not title:
        raise HTTPException(status_code=422, detail="Novel title is required")
    novel = {
        "id": str(uuid4()),
        "title": title,
        "author": payload.author.strip() or "Unknown",
        "description": payload.description.strip(),
        "languages": [payload.language],
        "chapter_count": 0,
        "visibility": "private",
    }
    NOVELS.append(novel)
    return novel


@app.post("/api/v1/import/epub")
async def import_epub(file: UploadFile = File(...)):
    filename = (file.filename or "").lower()
    if not filename.endswith(".epub"):
        raise HTTPException(status_code=400, detail="Please upload an .epub file")

    data = await file.read(MAX_UPLOAD_BYTES + 1)
    if len(data) > MAX_UPLOAD_BYTES:
        raise HTTPException(status_code=413, detail="EPUB exceeds the 25 MB development limit")
    if not data:
        raise HTTPException(status_code=400, detail="Uploaded file is empty")

    # Development-only storage. Add content validation, malware scanning,
    # ownership checks, and private object storage before public deployment.
    safe_name = f"{uuid4()}.epub"
    destination = UPLOAD_DIR / safe_name
    destination.write_bytes(data)

    return {
        "upload_id": safe_name.removesuffix(".epub"),
        "original_filename": file.filename,
        "size_bytes": len(data),
        "status": "uploaded_not_parsed",
        "message": "File received. EPUB chapter parsing is a later milestone.",
    }
