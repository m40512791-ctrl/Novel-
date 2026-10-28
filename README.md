# AI Novel Reader — Starter Project

This is a starter scaffold, not a finished production app.

## Contents
- `mobile/`: Flutter Android app starter UI with Home, Discover, Library, Creator Studio, and Profile tabs.
- `backend/`: FastAPI starter with health, novel list, and EPUB upload endpoints.
- `docker-compose.yml`: PostgreSQL service for local backend development.

## Prerequisites
- Flutter SDK + Android SDK
- Python 3.11+
- Docker Desktop or another PostgreSQL installation (optional for the first API smoke test)

## Run the backend
```bash
cd backend
python -m venv .venv
# Windows: .venv\Scripts\activate
# Linux/macOS: source .venv/bin/activate
pip install -r requirements.txt
uvicorn app.main:app --reload
```
Open `http://127.0.0.1:8000/docs` to inspect the API.

The starter's in-memory novel list and upload endpoint are for local prototyping only. They do not provide authentication, persistent storage, malware scanning, or production-grade EPUB parsing.

## Create/run the Flutter app
Install Flutter, then from this directory:
```bash
cd mobile
flutter create . --platforms=android
flutter pub get
flutter run
```
If `flutter create .` asks to overwrite files, keep the provided `lib/main.dart`.

For a physical Android phone, replace `localhost` in `mobile/lib/main.dart` with your development computer's LAN IP, and ensure both devices are on the same network. For Android emulator, use `10.0.2.2` instead of `localhost` to reach the host computer.

## Next development milestones
1. Add authentication and role-based permissions.
2. Add PostgreSQL models and migrations.
3. Implement secure object storage for EPUBs, covers, and audio.
4. Implement EPUB chapter extraction and private library.
5. Add translation jobs, glossary memory, and caching.
6. Add TTS provider integration on the backend only (never embed API keys in the APK).
7. Add publishing review, copyright reporting, audit logs, and tests.
