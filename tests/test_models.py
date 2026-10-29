"""
Test cases for Account Model
"""
import os
import logging
import unittest
from service import app
from service.models import Account, DataValidationError, db
from tests.factories import AccountFactory

DATABASE_URI = os.getenv(
    "DATABASE_URI", "postgresql://postgres:postgres@localhost:5432/postgres"
)


######################################################################
#  A C C O U N T   M O D E L   T E S T   C A S E S
######################################################################
class TestAccount(unittest.TestCase):
    """Test Cases for Account Model"""

    @classmethod
    def setUpClass(cls):
        """This runs once before the entire test suite"""
        app.config["TESTING"] = True
        app.config["DEBUG"] = False
        app.config["SQLALCHEMY_DATABASE_URI"] = DATABASE_URI
        app.logger.setLevel(logging.CRITICAL)
        Account.init_db(app)

    @classmethod
    def tearDownClass(cls):
        """This runs once after the entire test suite"""
        db.session.close()

    def setUp(self):
        """This runs before each test"""
        db.session.query(Account).delete()  # clean up the last tests
        db.session.commit()

    def tearDown(self):
        """This runs after each test"""
        db.session.remove()

    ######################################################################
    #  T E S T   C A S E S
    ######################################################################

    def test_create_an_account(self):
        """It should Create an Account and assert that it exists"""
        fake_account = AccountFactory()
        # pylint: disable=unexpected-keyword-arg
        account = Account(
            name=fake_account.name,
            email=fake_account.email,
            address=fake_account.address,
            phone_number=fake_account.phone_number,
            date_joined=fake_account.date_joined,
        )
        self.assertIsNotNone(account)
        self.assertEqual(account.id, None)
        self.assertEqual(account.name, fake_account.name)
        self.assertEqual(account.email, fake_account.email)
        self.assertEqual(account.address, fake_account.address)
        self.assertEqual(account.phone_number, fake_account.phone_number)
        self.assertEqual(account.date_joined, fake_account.date_joined)

    def test_add_a_account(self):
        """It should Create an account and add it to the database"""
        accounts = Account.all()
        self.assertEqual(accounts, [])
        account = AccountFactory()
        account.create()
        # Assert that it was assigned an id and shows up in the database
        self.assertIsNotNone(account.id)
        accounts = Account.all()
        self.assertEqual(len(accounts), 1)

    def test_read_account(self):
        """It should Read an account"""
        account = AccountFactory()
        account.create()

        # Read it back
        found_account = Account.find(account.id)
        self.assertEqual(found_account.id, account.id)
        self.assertEqual(found_account.name, account.name)
        self.assertEqual(found_account.email, account.email)
        self.assertEqual(found_account.address, account.address)
        self.assertEqual(found_account.phone_number, account.phone_number)
        self.assertEqual(found_account.date_joined, account.date_joined)

    def test_update_account(self):
        """It should Update an account"""
        account = AccountFactory()
        account.create()
        self.assertIsNotNone(account.id)
        # Change it and save it
        account.email = "changed@example.com"
        original_id = account.id
        account.update()
        self.assertEqual(account.id, original_id)
        self.assertEqual(account.email, "changed@example.com")
        # Fetch it back and make sure the id hasn't changed
        # but the data did change
        accounts = Account.all()
        self.assertEqual(len(accounts), 1)
        self.assertEqual(accounts[0].id, original_id)
        self.assertEqual(accounts[0].email, "changed@example.com")

    def test_delete_an_account(self):
        """It should Delete an account from the database"""
        accounts = Account.all()
        self.assertEqual(accounts, [])
        account = AccountFactory()
        account.create()
        accounts = Account.all()
        self.assertEqual(len(accounts), 1)
        account = accounts[0]
        account.delete()
        accounts = Account.all()
        self.assertEqual(len(accounts), 0)

    def test_list_all_accounts(self):
        """It should List all Accounts in the database"""
        accounts = Account.all()
        self.assertEqual(accounts, [])
        for _ in range(5):
            account = AccountFactory()
            account.create()
        # Assert that there are now 5 accounts in the database
        accounts = Account.all()
        self.assertEqual(len(accounts), 5)

    def test_find_by_name(self):
        """It should Find an Account by name"""
        account = AccountFactory()
        account.create()
        # Fetch it back by name
        same_account = Account.find_by_name(account.name)[0]
        self.assertEqual(same_account.id, account.id)
        self.assertEqual(same_account.name, account.name)

    def test_serialize_an_account(self):
        """It should Serialize an account"""
        account = AccountFactory()
        serial_account = account.serialize()
        self.assertEqual(serial_account["id"], account.id)
        self.assertEqual(serial_account["name"], account.name)
        self.assertEqual(serial_account["email"], account.email)
        self.assertEqual(serial_account["address"], account.address)
        self.assertEqual(serial_account["phone_number"], account.phone_number)
        self.assertEqual(serial_account["date_joined"], str(account.date_joined))

    def test_deserialize_an_account(self):
        """It should Deserialize an account"""
        account = AccountFactory()
        account.create()
        serial_account = account.serialize()
        new_account = Account()
        new_account.deserialize(serial_account)
        self.assertEqual(new_account.name, account.name)
        self.assertEqual(new_account.email, account.email)
        self.assertEqual(new_account.address, account.address)
        self.assertEqual(new_account.phone_number, account.phone_number)
        self.assertEqual(new_account.date_joined, account.date_joined)

    def test_deserialize_with_default_date(self):
        """It should default date_joined to today when it is not supplied"""
        data = {"name": "Jane", "email": "jane@example.com", "address": "1 Main St"}
        account = Account().deserialize(data)
        self.assertIsNotNone(account.date_joined)
        self.assertIsNone(account.phone_number)

    def test_deserialize_missing_data(self):
        """It should not Deserialize an account with missing data"""
        data = {"id": 1, "name": "Kitty Hawk", "email": "kh@example.com"}
        account = Account()
        self.assertRaises(DataValidationError, account.deserialize, data)

    def test_deserialize_bad_data(self):
        """It should not Deserialize bad data"""
        data = "this is not a dictionary"
        account = Account()
        self.assertRaises(DataValidationError, account.deserialize, data)

    def test_deserialize_bad_date(self):
        """It should not Deserialize a malformed date_joined"""
        data = {
            "name": "Jane",
            "email": "jane@example.com",
            "address": "1 Main St",
            "date_joined": "not-a-date",
        }
        account = Account()
        self.assertRaises(DataValidationError, account.deserialize, data)

    def test_repr(self):
        """It should have a readable representation"""
        account = AccountFactory()
        account.create()
        self.assertIn(account.name, repr(account))
