# Dropbox Python Authentication Tutorial

# Include Dropbox SDK libraries
from dropbox import client, rest, session

# Set APP_KEY, APP_SECRET, and ACCESS_TYPE
APP_KEY = 'ongci9riiqkrtll'
APP_SECRET = 'jyae8eqk2088hdp'
ACCESS_TYPE = 'app_folder'	# application has access to application folder only

# Set up session variable
sess = session.DropboxSession(APP_KEY, APP_SECRET, ACCESS_TYPE)

request_token = sess.obtain_request_token()

# User must authorize our application
# We'll send the user to the Dropbox website to allow our app access to their account
# Build url for user to authorize our application to access their Dropbox account
url = sess.build_authorize_url(request_token)
print 'Url: ', url
raw_input()

# We'll want to automatically send the user to the authorization URL
# and probably also pass in a callback URL so that the user is seamlessly redirected back to your app after pressing a button
#
#


# Once the user has successfully granted permission to your app
# we can upgrade the now-authorized request token to an access token

# This will fail if the user didn't visit the above URL and hit 'Allow'

access_token = sess.obtain_access_token(request_token)

# The access token is all you'll need for all future API requests on behalf of this user, 
# so you should store it away for safe-keeping (even though we don't for this tutorial). 
# By storing the access token, you won't need to go through these steps again unless 
# the user reinstalls your app or revokes access via the Dropbox website.

# Now that the hard part is done, all you'll need to sign your other API calls is 
# to pass the session object to DropboxClient and attach the object to your requests.
client = client.DropboxClient(sess)
