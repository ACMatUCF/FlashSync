# Dropbox Python Authentication Tutorial

# Include Dropbox SDK libraries
from dropbox import client, rest, session

# Set APP_KEY, APP_SECRET, and ACCESS_TYPE
APP_KEY = 'ongci9riiqkrtll'
APP_SECRET = 'jyae8eqk2088hdp'
ACCESS_TYPE = 'app_folder'	# application has access to application folder only

# Set up session variable
sess = session.DropboxSession(APP_KEY, APP_SECRET, ACCESS_TYPE)

