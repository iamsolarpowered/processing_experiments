class Waveform < Processing::App

  load_library 'minim'
  import 'ddf.minim'

  def setup
    frame_rate 30
    minim = Minim.new(self)
    @song = minim.get_line_in
  end
  
  def draw
    background(0) # Erase last frame
    draw_lines
  end
  
  def draw_lines
    @song.buffer_size.times do |i|
      # next unless i % 4 == 0
      draw_line(get_volume(:left, i), i)
      draw_line(get_volume(:right, i), i, 1)
    end
  end
  
  def draw_line(height, offset, line=0, color=127)
    stroke(color)
    height = (50 + (height * 75)) + (50 * line)
    line(offset, height, offset + 1, height)
  end
  
  
  def get_volume(channel, sample)
    @song.send(channel).get(sample)
  end

end

Waveform.new :title => "Waveform Thingy", :width => 1024, :height => 150

