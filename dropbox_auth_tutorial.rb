# Dropbox Ruby Authentication Tutorial

# Reference the dropbox_sdk.rb file included in the SDK download
require './dropbox-ruby-sdk-1.5.1/lib/dropbox_sdk'

# Set APP_KEY, APP_SECRET, and ACCESS_TYPE
APP_KEY = 'ongci9riiqkrtll'
APP_SECRET = 'jyae8eqk2088hdp'
ACCESS_TYPE = :app_folder	# application has access to application folder only

# Set up session variable
session = DropboxSession.new(APP_KEY, APP_SECRET)

# Request an authentication token
session.get_request_token

# token is automatically added to our session object
puts session.inspect

# User must authorize our application
# We'll send the user to the Dropbox website to allow our app access to their account
# Build url for user to authorize our application to access their Dropbox account
url = session.get_authorize_url
puts 'Url: ' + url
gets

# We'll want to automatically send the user to the authorization URL
# and probably also pass in a callback URL so that the user is seamlessly redirected back to your app after pressing a button
#
#


# Once the user has successfully granted permission to your app
# we can upgrade the now-authorized request token to an access token

# This will fail if the user didn't visit the above URL and hit 'Allow'
session.get_access_token

puts session.inspect
puts session.access_token
puts session.access_token.inspect
puts session.access_token.key
puts session.access_token.secret

# Ruby 1.9
#File.open('dropbox_token.txt', 'w') {|f| f.write session.access_token.key.to_s + ' ' + session.access_token.secret.to_s}

# Ruby 1.8
f = File.new('dropbox_token.txt', 'w')
f.write(session.serialize)
f.close()


# The access token is all you'll need for all future API requests on behalf of this user, 
# so you should store it away for safe-keeping (even though we don't for this tutorial). 
# By storing the access token, you won't need to go through these steps again unless 
# the user reinstalls your app or revokes access via the Dropbox website.

# Now that the hard part is done, all you'll need to sign your other API calls is 
# to pass the session object to DropboxClient and attach the object to your requests.
client = DropboxClient.new(session, ACCESS_TYPE)
puts 'linked account: ' + client.account_info().inspect