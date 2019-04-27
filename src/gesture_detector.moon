_ = require 'src.underscore'

doLinesIntersect = ( a, b, c, d ) ->
  -- parameter conversion
  L1 = {X1:a.x,Y1:a.y,X2:b.x,Y2:b.y}
  L2 = {X1:c.x,Y1:c.y,X2:d.x,Y2:d.y}

  -- Denominator for ua and ub are the same, so store this calculation
  d = (L2.Y2 - L2.Y1) * (L1.X2 - L1.X1) - (L2.X2 - L2.X1) * (L1.Y2 - L1.Y1)

  -- Make sure there is not a division by zero - this also indicates that the lines are parallel.
  -- If n_a and n_b were both equal to zero the lines would be on top of each
  -- other (coincidental).  This check is not done because it is not
  -- necessary for this implementation (the parallel check accounts for this).
  if (d == 0)
    return nil

  -- n_a and n_b are calculated as seperate values for readability
  n_a = (L2.X2 - L2.X1) * (L1.Y1 - L2.Y1) - (L2.Y2 - L2.Y1) * (L1.X1 - L2.X1)
  n_b = (L1.X2 - L1.X1) * (L1.Y1 - L2.Y1) - (L1.Y2 - L1.Y1) * (L1.X1 - L2.X1)

  -- Calculate the intermediate fractional point that the lines potentially intersect.
  ua = n_a / d
  ub = n_b / d

  -- The fractional point will be between 0 and 1 inclusive if the lines
  -- intersect.  If the fractional calculation is larger than 1 or smaller
  -- than 0 the lines would need to be longer to intersect.
  if (ua >= 0 and ua <= 1 and ub >= 0 and ub <= 1)
    x = L1.X1 + (ua * (L1.X2 - L1.X1))
    y = L1.Y1 + (ua * (L1.Y2 - L1.Y1))
    return true --, {x=x, y=y}

  nil


class GestureDetector
  new: =>
    @points = {}

  addPoint: (x, y) =>
    _.push(@points, {x: x, y: y})
    if #@points == 2
      first = _.first(@points)
      last = _.last(@points)
    elseif #@points > 3
      last = _.last(@points)

  clear: =>
    @points = {}

  isUppercut: =>
    first = _.first(@points)
    last = _.last(@points)

    topLeftFace = {x: display.contentCenterX - 20, y: display.contentCenterY - 350}
    bottomLeftFace = {x: display.contentCenterX - 20, y: display.contentCenterY - 200}
    bottomRightFace = {x: display.contentCenterX + 20, y: display.contentCenterY - 200}
    topRightFace = {x: display.contentCenterX + 20, y: display.contentCenterY - 350}
    doesIntersectLeft = doLinesIntersect(first, last, topLeftFace, bottomLeftFace)
    doesIntersectRight = doLinesIntersect(first, last, topRightFace, bottomRightFace)
    doesIntersectBottom = doLinesIntersect(first, last, bottomLeftFace, bottomRightFace)
    doesIntersectLeft or doesIntersectBottom or doesIntersectRight

{:GestureDetector}
