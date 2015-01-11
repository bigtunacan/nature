require 'rubygems'
#require 'gosu'
require 'ashton'
require 'byebug'

$width = 640
$height = 480

class MyWindow < Gosu::Window
  def initialize
    super($width, $height, false)
    self.caption = "Random Walk"

    @last_bg = nil
    @walker = Walker.new(self)
  end

  def update
    @walker.update
  end

  def draw
    @walker.draw
  end
end

LEFT = 0
RIGHT = 1
UP = 2
DOWN = 3

class Walker
  attr_accessor :x, :y, :z, :img, :direction
  attr_accessor :last_step_time
  attr_accessor :window
  attr_accessor :texture


  def initialize(window)
    self.img = Gosu::Image.new(window, "assets/sphere.png", false)
    self.window = window
    self.x = window.width/2 - self.img.width/2
    self.y = window.height/2 - self.img.height/2
    self.z = 0
    self.step
    self.texture = Ashton::Texture.new $width, $height
  end

  def draw
    #@texture.render do
      #self.img.draw(self.x,self.y,self.z)
    #end
    self.texture.draw 0, 0, 0
    #window.primary_buffer.draw 0, 0, 0
  end

  def update
    self.texture.render do
      #self.img.draw(self.x,self.y,self.z)
      #byebug
      #self.img.draw(self.x,0,self.z)
      self.img.draw(150,0,0)
    end

    #window.primary_buffer.render do
      #window.pixel.draw 0, 0, 0, 250, 250, 0xaaff0000
      #self.img.draw(self.x,self.y,self.z)
      #self.img.draw(0,0,0)
    #end
    self.step if Time.now - self.last_step_time > 2

    # TODO: Refactor; this is to complex
    if self.direction == LEFT
      if self.x > 0
        self.x -= 1
      else
        self.step
      end
    elsif self.direction == RIGHT
      if self.x + self.img.width < self.window.width
        self.x += 1
      else
        self.step
      end
    elsif self.direction == DOWN
      if self.y + self.img.height < self.window.height
        self.y += 1
      else
        step
      end
    elsif self.direction == UP
      if self.y > 0
        self.y -= 1
      else
        step
      end
    end
  end

  def step
    self.direction = Random.new.rand(0..3)
    self.last_step_time = Time.now
  end

end
window = MyWindow.new
window.show
