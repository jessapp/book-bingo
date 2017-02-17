import unittest

import server

class RouteTests(unittest.TestCase):
    """Tests for my server"""

    def setUp(self):
        self.client = server.app.test_client()
        server.app.config['TESTING'] = True

    def test_homepage(self):
        result = self.client.get("/")
        self.assertIn("Book Bingo", result.data)



if __name__ == "__main__":
    unittest.main()