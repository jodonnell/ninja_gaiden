require 'RMagick'
include Magick

class Rect
  attr_accessor :x, :y, :width, :height

  def incomplete?
    x.nil? or y.nil? or width.nil? or height.nil?
  end

  def complete?
    not incomplete?
  end

  def right_side
    return false if x.nil? or width.nil?
    x + width
  end

  def to_s
    "#{x} #{y} #{width} #{height}"
  end
end


class FindRectangle
  attr_accessor :rect

  def initialize
    @rect_started = false
    @is_traveling_line = false
    @traveling_down_line = false
    @rect = Rect.new
  end

  def look_at_pixel pixel, x, y
    if pixel.opacity == 0 && @rect_started == false
      @rect_started = true
      @rect.x = x
      @rect.y = y
      @is_traveling_line = true
    elsif pixel.opacity != 0 and @is_traveling_line
      @is_traveling_line = false

      @rect.width = x - 1 - @rect.x
    elsif pixel.opacity == 0 and x == @rect.right_side
      @traveling_down_line = true
    elsif pixel.opacity != 0 and @traveling_down_line and x == @rect.right_side
      @traveling_down_line = false
      @rect.height = y - 1 - @rect.y
    end
  end

end

image = Image.read("first_stage_rects.png").first

fr = FindRectangle.new
image.each_pixel do |pixel, x, y|
  fr.look_at_pixel pixel, x, y
end

puts fr.rect

