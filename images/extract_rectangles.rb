require 'RMagick'
include Magick

$count = 1

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

  def bottom_side
    y + height
  end

  def to_s
    #"#{x} #{y} #{width} #{height}"
    "self.rects[#{$count}] = Rect(#{x}, #{y + 120}, #{width}, #{height})"
  end
end


class FindRectangle
  attr_accessor :rect

  def initialize rects
    @rect_started = false
    @is_traveling_line = false
    @traveling_down_line = false
    @rect = Rect.new
    @previous_rects = rects
  end

  def not_in_previous_rects x, y
    @previous_rects.each do |rect|
      return false if (x >= rect.x and x <= rect.right_side) and (y >= rect.y and y <= rect.bottom_side)
    end
    true
  end

  def look_at_pixel pixel, x, y
    if pixel.opacity == 0 && @rect_started == false && not_in_previous_rects(x, y)
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

rects = []

while 1==1 do
  fr = FindRectangle.new rects
  image.each_pixel do |pixel, x, y|
    fr.look_at_pixel pixel, x, y
    if fr.rect.complete?
      rects.push fr.rect
      puts fr.rect
      break
    end
  end
  $count += 1
  break if fr.rect.incomplete?
end
