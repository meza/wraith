require "wraith/version"

module Wraith
  require 'wraith/wraith_logger'
  require 'wraith/save_images'
  require 'wraith/crop'
  require 'wraith/spider'
  require 'wraith/folder'
  require 'wraith/thumbnails'
  require 'wraith/compare_images'
  require 'wraith/gallery'
  require 'wraith/command_line_image_tool'

  autoload :Environment, 'wraith/environment'
  autoload :CLI, 'wraith/cli'
  autoload :Error, 'wraith/error'
end
