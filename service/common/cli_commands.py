"""
Flask CLI Command Extensions
"""
from service import app  # Import Flask application
from service.models import db


@app.cli.command("db-create")
def db_create():
    """
    Recreates a local database. You probably should NOT use this on
    production. ;-)
    """
    db.drop_all()
    db.create_all()
    db.session.commit()
