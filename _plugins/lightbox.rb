# Jekyll Lightbox Plugin
#
# example: {% lightbox --class class1 --class class2 --thumb thumb.jpg --group group1 --alt "image three" --title "this is image three" image.jpg %}
#
# + Double quotes are optional if the text contains no spaces
# + shorthand version of options can be used
# + option and argument can be separated by a space or equals sign
# + arguments cannot contain a double-quote character
#
# (MIT License)
# 
# Copyright (c) Reuben Peeris (reuben@reubenpeeris.com)
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
#
require 'optparse'

module Jekyll
 class LightboxTag < Liquid::Tag
  def initialize(tag_name, text, tokens)
   super
   @classes = "lightbox-thumb"
   alt_title = false

   args = text.scan(/(?:[^" ]+|"[^"]*")+/).collect{|e| e.delete('"')}
   OptionParser.new do |opts|
    opts.banner = "Usage: example.rb [options]"

    opts.on("-a", "--alt ARG", "alt text for image") do |arg|
     @alt = arg
    end

    opts.on("-c", "--class ARG", "append additional class") do |arg|
     @classes = @classes + " " + arg
    end

    opts.on("-g", "--group ARG", "group that image belongs to (leave blank for individual)") do |arg|
     @group = arg
    end

    opts.on("-t", "--title ARG", "image title") do |arg|
     @title = arg
    end

    opts.on("-T", "--thumb ARG", "image thumbnail") do |arg|
     @thumb = arg
    end

    opts.on("-A", "--alt-title", "use the alt text for the title") do |arg|
     alt_title = true
    end
   end.parse! args

   if args.length != 1
    raise "required exactly one image url, got #{args.length} in '#{args}'"
   end

   @image = args.pop

   if @thumb == nil
    @thumb = @image
   end

   if @group == nil
    @group = @image
   end

   if alt_title
    if @title != nil
     raise "Requires up to 1 title, 2 provided: --alt-title and --title"
    end
    @title = @alt
   end
  end

  def render(context)
   %{<a href="#{@image}" data-lightbox="#{@group}" data-title="#{@title}"><img src="#{@thumb}" alt="#{@alt || @title}" class="lightbox-thumb #{@classes}" /></a>}
  end
 end
end

Liquid::Template.register_tag('lightbox', Jekyll::LightboxTag)

