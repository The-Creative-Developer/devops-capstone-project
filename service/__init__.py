"""
Flask application factory-style package for the Accounts service.

Importing this package creates the Flask ``app`` and wires up security
(Flask-Talisman), CORS (Flask-Cors), routes, error handlers and the database.
"""
import sys
from flask import Flask
from flask_talisman import Talisman
from flask_cors import CORS
from service import config
from service.common import log_handlers

# Create Flask application
app = Flask(__name__)
app.config.from_object(config)

# Security headers (HSTS, X-Frame-Options, CSP, ...) and CORS policy
talisman = Talisman(app)
CORS(app)

# Dependencies require we import the routes AFTER the Flask app is created
# pylint: disable=wrong-import-position, cyclic-import, wrong-import-order
from service import routes, models  # noqa: F401 E402
from service.common import error_handlers, cli_commands  # noqa: F401 E402

# Set up logging for production
log_handlers.init_logging(app, "gunicorn.error")

app.logger.info(70 * "*")
app.logger.info("  A C C O U N T   S E R V I C E   R U N N I N G  ".center(70, "*"))
app.logger.info(70 * "*")

try:
    models.init_db(app)  # make our database tables
except Exception as error:  # pylint: disable=broad-except
    app.logger.critical("%s: Cannot continue", error)
    # gunicorn requires exit code 4 to stop spawning workers when it dies
    sys.exit(4)

app.logger.info("Service initialized!")
