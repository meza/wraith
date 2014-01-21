require 'erb'
require 'pp'
require 'fileutils'


MATCH_FILENAME = /(\S+)_(\S+)\.\S+/

TEMPLATE_LOCATION = File.expand_path('gallery_template/gallery_template.erb', File.dirname(__FILE__))
TEMPLATE_BY_DOMAIN_LOCATION = File.expand_path('gallery_template/gallery_template.erb', File.dirname(__FILE__))
BOOTSTRAP_LOCATION = File.expand_path('gallery_template/bootstrap.min.css', File.dirname(__FILE__))

def parse_directories(dirname)
  dirs = {}
  categories = Dir.foreach(dirname).select do |category|
    if ['.', '..', 'thumbnails'].include? category
      # Ignore special dirs
      false
    elsif File.directory? "#{dirname}/#{category}" then
      # Ignore stray files
      true
    else
      false
    end
  end

  categories.each do |category|
    dirs[category] = {}
    Dir.foreach("#{dirname}/#{category}") do |filename|
      match = MATCH_FILENAME.match(filename)
      if not match.nil? then
        size = match[1].to_i
        group = match[2]
        filepath = category + "/" + filename
        thumbnail = "thumbnails/#{category}/#{filename}"

        if dirs[category][size].nil? then
          dirs[category][size] = {:variants => []}
        end
        size_dict = dirs[category][size]

        case group
          when 'diff'
            size_dict[:diff] = {
                :filename => filepath, :thumb => thumbnail
            }
          when 'data'
            size_dict[:data] = File.read("#{dirname}/#{filepath}")
          else
            size_dict[:variants] << {
                :name => group,
                :filename => filepath,
                :thumb => thumbnail
            }

        end
        size_dict[:variants].sort! {|a, b| a[:name] <=> b[:name] }
      end
    end
  end

  return dirs
end

def generate_html(domain, directories, template, destination)
  template = File.read(template)
  html = ERB.new(template).result
  File.open(destination, 'w') do |outf|
    outf.write(html)
  end
end

def dosTuff(location)
  dest = "#{location}/gallery.html"
  directories = parse_directories(location);
  generate_html(location, directories, TEMPLATE_BY_DOMAIN_LOCATION, dest)
  FileUtils.cp(BOOTSTRAP_LOCATION, "#{location}/bootstrap.min.css")

end