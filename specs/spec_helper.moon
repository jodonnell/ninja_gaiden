class Quad
  new: (x, y, w, h, sw, sh) =>
    @x = x
    @y = y
    @w = w
    @h = h
    @sw = sw
    @sh = sh

  getViewport: =>
    @x, @y, @w, @h

class Image
  getWidth: =>
    10

  getHeight: =>
    10

_G.test_image = Image!

_G.love = {
  graphics: {
    newImage: () -> test_image
    newQuad: (x, y, width, height, sw, sh) -> Quad(x, y, width, height, sw, sh)
    draw: () ->
    getDimensions: () -> 414, 736
  }
}

_G.Quad = Quad
