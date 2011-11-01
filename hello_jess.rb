class HelloJess < Processing::App

  load_library 'minim'
  import 'ddf.minim'

  def setup
    frame_rate 10
    color_mode RGB, 1
    minim = Minim.new(self)
    @song = minim.load_file("/home/ben/Music/Lisa Jaeggi - Oh Lady You Shot Me.mp3", 512)
    @song.play
  end
  
  def draw
    fill *Color.random(current_volume + 1)
    rect(rand(width), rand(height), rand(width), rand(height))
  end
  
  def current_volume
    buffer_size = @song.buffer_size
    @song.left.get(buffer_size - 1) + @song.right.get(buffer_size - 1)
  end

  module Color
    def self.random(brightness)
      high = 0.5 * brightness
      low = 0.1 * brightness
      palate = [[high, low, low], [low, high, high], [low, low, high]]
      palate[rand(palate.length)]
    end
  end
  
end

HelloJess.new :title => "Hi :)", :width => 800, :height => 600

