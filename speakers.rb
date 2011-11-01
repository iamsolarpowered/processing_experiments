class Speakers < Processing::App

  load_library 'minim'
  import 'ddf.minim'
  
  LEFT_CENTER = [200, 300]
  RIGHT_CENTER = [600, 300]
  MIN_WIDTH = 100
  MAX_WIDTH = 300
  
  BUFFER_SIZE = 512

  def setup
    frame_rate 30
    color_mode RGB, 1
    minim = Minim.new(self)
    @song = minim.load_file("/home/ben/Music/Lisa Jaeggi - Oh Lady You Shot Me.mp3", BUFFER_SIZE)
    @song.play
    draw_speaker(0.5, LEFT_CENTER)
    draw_speaker(0.5, RIGHT_CENTER)
  end
  
  def draw
    draw_speakers
  end
  
  def draw_speakers
    draw_speaker(get_volume(:left), LEFT_CENTER)
    draw_speaker(get_volume(:right), RIGHT_CENTER)
  end
  
  def draw_speaker(volume, center)
    width = ((volume + 1) * (MIN_WIDTH - MAX_WIDTH)) + MIN_WIDTH
    ellipse(*[center, width, width].flatten)
  end
  
  def get_volume(channel)
    @song.send(channel).get(BUFFER_SIZE - 1)
  end

end

Speakers.new :title => "Hi :)", :width => 800, :height => 600

