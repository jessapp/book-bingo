# API Calls

import os

import requests

import xmltodict

import urllib

access_token = os.environ['GOODREADS_ACCESS_DEVELOPER_KEY']

def create_url(title):
    """Creates URL given book title"""

    title = urllib.quote_plus(title)

    url = "https://www.goodreads.com/search/index.xml?key=" + access_token + "&q=" + title

    return url


def url_to_dict(url):
    """Creates dict from XML response"""

    result = requests.get(url)

    out_xml = result.text

    xmldict = xmltodict.parse(out_xml)

    return xmldict

def get_title(xmldict):
    """Gets book tile from XML Dict""" 

    title = xmldict['GoodreadsResponse']['search']['results']['work'][0]['best_book']['title']

    return title

def get_author(xmldict):
    """Gets author name from XML Dict"""

    author = xmldict['GoodreadsResponse']['search']['results']['work'][0]['best_book']['author']['name']

    return author

def get_image_url(xmldict):
    """Gets image URL From XML Dict"""

    image_url = xmldict['GoodreadsResponse']['search']['results']['work'][0]['best_book']['image_url']

    return image_url

def get_goodreads_id(xmldict):

    goodreads_id = xmldict['GoodreadsResponse']['search']['results']['work'][0]['best_book']['id']['#text']

    return goodreads_id


def get_description(goodreads_id):
    """Takes Goodreads ID as a string to get description with another API call"""

    id_url = "https://www.goodreads.com/book/show/" + goodreads_id + ".xml?key=" + access_token

    result = requests.get(id_url)

    xml_out = result.text

    xmldict = xmltodict.parse(xml_out)

    description = xmldict['GoodreadsResponse']['book']['description']

    return description 

