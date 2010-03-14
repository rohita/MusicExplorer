require 'test_helper'

class LfmTrackTest < ActiveSupport::TestCase
  def setup
    @track = LfmTrack.find("Glory Box","Portishead")
  end

  test "can get track name" do
    assert_equal "Glory Box", @track.name
  end  
  
  test "can get duration" do
    assert_equal "305000", @track.duration
  end
  
  test "can get artist name" do
    assert_equal "Portishead", @track.artist_name
  end
  
  test "can get ablum name" do
    assert_equal "Dummy", @track.album_name
  end
  
  test "can get track image url" do
    assert_equal "http://userserve-ak.last.fm/serve/300x300/9485831.jpg", @track.image_url
  end
  
  test "can get track description" do
    expected = "Like <a href=\"http://www.last.fm/music/Tricky\" class=\"bbcode_artist\">Tricky</a>'s " +
      "<a title=\"Tricky &ndash; Hell Is Around the Corner\" href=\"http://www.last.fm/music/Tricky/_/Hell+Is+Around+the+Corner\" " + 
      "class=\"bbcode_track\">Hell Is Around the Corner</a>, this track contains a distinctive sample from " +
      "<a href=\"http://www.last.fm/music/Isaac+Hayes\" class=\"bbcode_artist\">Isaac Hayes</a>'s <a title=\"Isaac Hayes &ndash; " +
      "Ike's Rap II\" href=\"http://www.last.fm/music/Isaac+Hayes/_/Ike%27s+Rap+II\" class=\"bbcode_track\">Ike's Rap II</a>."
    assert_equal expected, @track.description
  end

  test "can get similar tracks" do
    assert_equal 10, @track.similar_tracks.count
    
  end
  

  test "favorite" do
    assert @track.is_favorite_of(1)
    assert !@track.is_favorite_of(2)
  end
end
