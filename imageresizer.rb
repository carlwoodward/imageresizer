require 'rubygems'
require 'sinatra'
require 'mini_magick'
require 'digest/md5'
require 'fileutils'



get '/' do
  file = find_in_cache_or_resize params[:u], params[:d]
  send_file file
end