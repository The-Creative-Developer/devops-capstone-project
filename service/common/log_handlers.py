"""
Log Handlers

Route Flask's logger through the gunicorn error logger when running under gunicorn.
"""
import logging


def init_logging(app, logger_name: str):
    """Set up logging for production"""
    app.logger.propagate = False
    app.logger.handlers = []

    gunicorn_logger = logging.getLogger(logger_name)
    app.logger.handlers = gunicorn_logger.handlers
    app.logger.setLevel(gunicorn_logger.level or logging.INFO)

    formatter = logging.Formatter(
        "[%(asctime)s] [%(levelname)s] [%(module)s] %(message)s", "%Y-%m-%d %H:%M:%S %z"
    )
    for handler in app.logger.handlers:
        handler.setFormatter(formatter)
    app.logger.info("Logging handler established")
