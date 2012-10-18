# An example use of the /chunked_upload API call.

require './lib/dropbox_sdk'

# You must use your Dropbox App key and secret to use the API.
# Find this at https://www.dropbox.com/developers
APP_KEY = ''
APP_SECRET = ''
ACCESS_TYPE = :app_folder #The two valid values here are :app_folder and :dropbox
                          #The default is :app_folder, but your application might be
                          #set to have full :dropbox access.  Check your app at
                          #https://www.dropbox.com/developers/apps


STATE_FILE = 'search_cache.json'

def main()
    if APP_KEY == '' or APP_SECRET == ''
        warn "ERROR: Set your APP_KEY and APP_SECRET at the top of search_cache.rb"
        exit
    end
    prog_name = __FILE__
    args = ARGV
    if args.size == 0
        warn("Usage:\n")
        warn("   #{prog_name} <local-file-path> <dropbox-target-path> <chunk-size-in-bytes>")
        exit
    end

    if args.size != 3
        warn "ERROR: expecting exactly three arguments.  Run with no arguments for help."
        exit(1)
    end

    sess = DropboxSession.new(APP_KEY, APP_SECRET)
    sess.get_request_token

    # Make the user log in and authorize this token
    url = sess.get_authorize_url
    puts "1. Go to: #{url}"
    puts "2. Authorize this app."
    puts "After you're done, press ENTER."
    STDIN.gets

    # This will fail if the user didn't visit the above URL and hit 'Allow'
    sess.get_access_token
    puts "Link successful."
    c = DropboxClient.new(sess, ACCESS_TYPE)

    local_file_path = args[0]
    dropbox_target_path = args[1]
    chunk_size = args[2].to_i

    # Upload the file
    local_file_size = File.size(local_file_path)
    uploader = c.get_chunked_uploader(File.new(local_file_path, "r"), local_file_size)
    retries = 0
    puts "Uploading..."
    while uploader.offset < uploader.total_size
        begin
            uploader.upload(chunk_size)
        rescue DropboxError => e
            if retries > 10
                puts "- Error uploading, giving up."
                break
            end
            puts "- Error uploading, trying again..."
            retries += 1
        end
    end
    puts "Finishing upload..."
    uploader.finish(dropbox_target_path)
    puts "Done."

end

main()
