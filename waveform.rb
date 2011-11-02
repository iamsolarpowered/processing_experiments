class Waveform < Processing::App

  load_library 'minim'
  import 'ddf.minim'
  
  BUFFER_SIZE = 1024
  SONGS = Dir["/home/ben/Music/*.mp3"]

  def setup
    size 1024, 150
    frame_rate 30
    
    @color_array = [255, 255, 0]
    @color = color(*@color_array) 
    stroke @color
    fill @color
    
    @font = load_font "Ziggurat-HTF-Black-32.vlw"
    text_font @font, 32
    
    @minim = Minim.new(self)
  end
  
  def draw
    background(0) # Erase last frame
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
    alpha = (-255 * height) + 32
    stroke(*[@color_array, alpha].flatten)
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

