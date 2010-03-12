require 'test_helper'

class LfmArtistTest < ActiveSupport::TestCase
  def setup
    @artist = LfmArtist.find("Portishead")
  end

  test "can get artist name" do
    assert_equal "Portishead", @artist.name
  end  
  
  test "can get artist image url" do
    assert_equal "http://userserve-ak.last.fm/serve/252/37074089.jpg", @artist.image_url
  end
  
  test "can get artist bio" do
    expected = "Portishead is a band from Bristol, <a href=\"http://www.last.fm/tag/English+Artists\">England</a>, " +
      "named after a small coastal town twelve miles west of said musical hotbed, " +
      "in North Somerset. They were initially known for their use of <a href=\"http://www.last.fm/tag/jazz\" class=\"bbcode_tag\" " + 
      "rel=\"tag\">jazz</a> samples and some <a href=\"http://www.last.fm/tag/hip-hop\" class=\"bbcode_tag\" " + 
      "rel=\"tag\">hip-hop</a> beats along with various synth sounds and the hauntingly beautiful vocals of singer Beth Gibbons. " +
      "Their current sound drops the samples in favour of a harder, more abrasive edge, but retains Gibbons' vocals.  "
    assert_equal expected, @artist.bio
  end
  
  test "can get similar artists" do
    assert_equal "Beth Gibbons & Rustin Man", @artist.similar_artists[0].name
    assert_equal "Massive Attack", @artist.similar_artists[1].name
    assert_equal "Tricky", @artist.similar_artists[2].name
    assert_equal "Lamb", @artist.similar_artists[3].name
    assert_equal "Hooverphonic", @artist.similar_artists[4].name
    
    assert_equal "http://userserve-ak.last.fm/serve/64s/135605.jpg", @artist.similar_artists[0].image_url
    assert_equal "http://userserve-ak.last.fm/serve/64s/41665797.png", @artist.similar_artists[1].image_url
    assert_equal "http://userserve-ak.last.fm/serve/64s/28182753.jpg", @artist.similar_artists[2].image_url
    assert_equal "http://userserve-ak.last.fm/serve/64s/35040.jpg", @artist.similar_artists[3].image_url
    assert_equal "http://userserve-ak.last.fm/serve/64s/40553471.png", @artist.similar_artists[4].image_url
  end
  
  test "can get top tracks" do
    assert_equal "Roads", @artist.top_tracks[0]
    assert_equal "Glory Box", @artist.top_tracks[1]
    assert_equal "Sour Times", @artist.top_tracks[2]
    assert_equal "Mysterons", @artist.top_tracks[3]
    assert_equal "Strangers", @artist.top_tracks[4]
    assert_equal "Numb", @artist.top_tracks[5]
    assert_equal "The Rip", @artist.top_tracks[6]
    assert_equal "It Could Be Sweet", @artist.top_tracks[7]
    assert_equal "Wandering Star", @artist.top_tracks[8]
    assert_equal "Silence", @artist.top_tracks[9]
    
  end
  
  test "favorite" do
    assert @artist.is_favorite_of(1)
    assert !@artist.is_favorite_of(2)
  end
end
