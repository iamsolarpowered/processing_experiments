class Waveform < Processing::App

  load_library 'control_panel'
  load_library 'minim'
  import 'ddf.minim'
  
  BUFFER_SIZE = 1024
  SONGS = Dir["/home/ben/Music/*.mp3"]

  def setup
    size 1024, 150
    frame_rate 30
    
    color_mode HSB, 100
    
    @font = load_font "Ziggurat-HTF-Black-32.vlw"
    text_font @font, 32
    
    @minim = Minim.new(self)
    
    control_panel do |c|
      c.slider :hue, 0..100, 16
      c.slider :saturation, 0..100, 85
      c.slider :brightness, 0..100, 85
    end
  end
  
  def draw
    background(0) # Erase last frame
    stroke @hue, @saturation, @brightness
    fill @hue, @saturation, @brightness
    play_random_song unless @song && @song.is_playing
    text @title, 10, 140
    draw_channel(:left)
    draw_channel(:right, 1)
  end
  
  def draw_channel(channel, line=0)
    @song.send(channel).to_array.each_with_index do |sample, i|
      draw_line(sample, i, line)
    end
  end
  
  def draw_line(height, offset, line=0)
    # alpha = (-255 * height) + 32
    # stroke(@hue, @saturation, @brightness)
    height = (50 + (height * 75)) + (50 * line)
    line(offset, height, offset + 1, height)
  end
  
  def play_random_song
    @song = @minim.load_file(SONGS[rand(SONGS.length)], BUFFER_SIZE)
    if data = @song.get_meta_data rescue false
      @title = "#{data.title} by #{data.author}"
    end
    @song.play
  end

end

Waveform.new :title => "Waveform Thingy"

