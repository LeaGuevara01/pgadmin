import os

DEFAULT_SERVER = '0.0.0.0'
DEFAULT_SERVER_PORT = int(os.environ.get("PORT", 10000))

SQLITE_PATH = os.environ.get("PGADMIN_DATA_DIR", "/var/lib/pgadmin")
LOG_FILE = os.path.join(SQLITE_PATH, "pgadmin4.log")
SESSION_DB_PATH = os.path.join(SQLITE_PATH, "sessions")
STORAGE_DIR = os.path.join(SQLITE_PATH, "storage")
AZURE_CREDENTIAL_CACHE_DIR = os.path.join(SQLITE_PATH, "azurecredentialcache")
