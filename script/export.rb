#!/usr/bin/env ruby

require_relative "../config/environment"

export_base = ARGV.shift || raise("usage: #{$0} <export_path>")
Dir.mkdir(export_base) unless File.directory?(export_base)

Collection.all.sort_by(&:title).each do |collection| 
  collection_path = File.join(export_base, collection.title)
  Dir.mkdir(collection_path) unless File.directory?(collection_path)
  puts "Processing collection [#{collection.title}]: [#{collection_path}]"

  collection.albums.sort_by(&:title).each do |album|
    album_path = File.join(collection_path, album.title)
    Dir.mkdir(album_path) unless File.directory?(album_path)
    puts " --> Processing album [#{album.title}]: [#{album_path}]"
    photo_count = album.photos.size
    album.photos.sort_by(&:created_at).each_with_index do |photo,p|
      photo_path = File.join(album_path, File.basename(photo.file.path))
      puts "    --> Processing photo #{p+1}/#{photo_count}: [#{photo_path}]"
      written = File.open(photo_path, "wb") { |f| f.write photo.file.read }
      puts "          (wrote #{written} bytes)"
    end
  end
end
