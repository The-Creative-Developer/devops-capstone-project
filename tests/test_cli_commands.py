"""
Test Cli Commands
"""
from unittest import TestCase
from unittest.mock import patch
from service import app
from service.common.cli_commands import db_create


class TestFlaskCLI(TestCase):
    """Test Flask CLI Commands"""

    @patch("service.common.cli_commands.db")
    def test_db_create(self, db_mock):
        """It should call the db-create command"""
        runner = app.test_cli_runner()
        result = runner.invoke(db_create)
        self.assertEqual(result.exit_code, 0)
        db_mock.drop_all.assert_called_once()
        db_mock.create_all.assert_called_once()
        db_mock.session.commit.assert_called_once()
