require 'test_helper'

class LibraryTest < ActiveSupport::TestCase
  
  def setup
    file_path = "#{RAILS_ROOT}/test/fixtures/small_lib.xml"
    @library = Library.new
    @library.parse(file_path)
    @library.save!
  end
 
  test "number of tracks" do
    expected = 41
    actual = @library.number_of_tracks
    assert_equal expected, actual
  end

  test "number of artists" do
    expected = 12
    actual = @library.number_of_artists
    assert_equal expected, actual
  end
  
  test "number of albums" do
    expected = 20
    actual = @library.number_of_albums
    assert_equal expected, actual
  end
   
  test "total playtime" do
    expected = 9078532
    actual = @library.total_playtime
    assert_equal expected, actual
  end
  
  test "total playtime formatted" do
    expected = "2:31"
    actual = @library.total_playtime_formatted
    assert_equal expected, actual
  end
 
  test "test_top_1_play_count" do
    result = @library.top_tracks_by_play_count(1)
    expected = [24, "Kick In The Eye"]
    actual = [result[0].play_count.to_i, result[0].name]
    assert_equal expected, actual 
  end
   
  test "test_top_3_play_count" do
    result = @library.top_tracks_by_play_count(3)
    expected = ["Kick In The Eye", "Lagartija Nick", "Lazy Eye"]
    actual = [result[0].name, result[1].name, result[2].name]
    assert_equal expected, actual
  end

end
