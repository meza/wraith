#!/usr/bin/env ruby

# Given all the screenshots in the shots/ directory, produces a nice looking
# gallery


require 'gallery_helper'


if ARGV.length < 1 then
    puts "USAGE: create_gallery.rb <directory>"
    exit 1
end

dosTuff(ARGV[0])

