class Speakers < Processing::App

  load_library 'minim'
  import 'ddf.minim'
  

  def setup
    frame_rate 30
    minim = Minim.new(self)
    @song = minim.get_line_in
  end
  
  def draw
    background(255)
    draw_lines
  end
  
  def draw_lines
    @song.buffer_size.times do |i| 
      draw_line(get_volume(:left, i), i)
      draw_line(get_volume(:right, i), i)
    end
  end
  
  def draw_line(height, offset)
    height = 50 + (height * 50) # make it bigger!
    line(offset, height, offset + 1, height)
  end
  
  
  def get_volume(channel, sample)
    @song.send(channel).get(sample)
  end

end

Speakers.new :title => "Hi :)", :width => 800, :height => 600

