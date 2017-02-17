import unittest

import goodreads

from goodreads import (url_to_dict, create_url, get_title, get_author, get_image_url,
                        get_goodreads_id, get_description)


class GoodreadsTests(unittest.TestCase):
    """Tests for GoodReads API calls"""

    xmldict = url_to_dict("https://www.goodreads.com/search/index.xml?key=57iWBPEbWuijEvz7vjVKA&q=Ender%27s+Game")
    enders_game_id = get_goodreads_id(xmldict)

    def test_url(self):
        self.assertEqual(create_url("Ender's Game"), 
            'https://www.goodreads.com/search/index.xml?key=57iWBPEbWuijEvz7vjVKA&q=Ender%27s+Game')


    def test_title(self):
        self.assertEqual(get_title(self.xmldict), "Ender's Game (Ender's Saga, #1)")


    def test_author(self):
        self.assertEqual(get_author(self.xmldict), "Orson Scott Card")


    def test_image_url(self):
        self.assertEqual(get_image_url(self.xmldict), "https://images.gr-assets.com/books/1408303130m/375802.jpg")

    def test_get_id(self):
        self.assertEqual(get_goodreads_id(self.xmldict), "375802")

if __name__ == "__main__":
    unittest.main()