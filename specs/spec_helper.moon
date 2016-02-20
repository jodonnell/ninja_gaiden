class Image
  getWidth: =>
    10

  getHeight: =>
    10

_G.test_image = Image!

_G.love = {
  graphics: {
    newImage: () -> test_image
    newQuad: () -> 1
    draw: () ->
  }
}
