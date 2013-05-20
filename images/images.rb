require 'RMagick'
include Magick

$original_image = ImageList.new("ninjagaiden2sheet1.gif")
def create_image image_name, x, y, w, h, flop=false
  image = $original_image.crop(x, y, w, h)
  image = image.scale(2.7)
  image = image.flop if flop
  image.write("#{image_name}.png")
end

create_image "ryu_stand", 2, 2, 17, 32
create_image "ryu_attack_begin", 37, 2, 17, 32
create_image "ryu_attack_middle", 59, 2, 40, 32
create_image "ryu_attack_end", 106, 2, 31, 32
create_image "ryu_special", 180, 2, 27, 32

create_image "ryu_ducking", 223, 10, 17, 24
create_image "ryu_ducking_attack_begin", 260, 10, 17, 24
create_image "ryu_ducking_attack_middle", 284, 10, 40, 24
create_image "ryu_ducking_attack_end", 329, 10, 31, 24

create_image "ryu_right_jump", 2, 41, 20, 24
create_image "ryu_down_jump", 28, 41, 20, 24
create_image "ryu_left_jump", 50, 41, 20, 24
create_image "ryu_up_jump", 76, 41, 20, 24

create_image "ryu_falling_attack_begin", 114, 41, 17, 31
create_image "ryu_falling_attack_middle", 160, 41, 38, 31
create_image "ryu_falling_attack_end", 204, 41, 28, 31

create_image "ryu_falling_special", 278, 41, 24, 31
create_image "ryu_falling", 324, 40, 21, 31


create_image "ryu_climb", 2, 81, 15, 31, true
create_image "ryu_climb_arms", 23, 81, 15, 31, true

create_image "ryu_climb_special_begin", 59, 80, 15, 31, true
create_image "ryu_climb_special_in_end", 79, 80, 21, 31, true
create_image "ryu_climb_special_out_end", 143, 79, 31, 32, true

create_image "ryu_running_1", 207, 80, 20, 31
create_image "ryu_running_2", 236, 80, 22, 31
create_image "ryu_running_3", 268, 80, 20, 31

$original_image = ImageList.new("ninjagaiden2sheet2.gif")

create_image "hunchback_walk1", 5, 16, 23, 29
create_image "hunchback_walk2", 31, 16, 25, 29

# convert old.png  -fill '#new_color' -opaque '#old_color' new.png
