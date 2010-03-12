require 'test_helper'

class LfmAlbumTest < ActiveSupport::TestCase
  
  def setup
    @album = LfmAlbum.find("Dummy", "Portishead")
  end

  test "can get album title" do
    assert_equal "Dummy", @album.title
  end
  
  test "can get album artist name" do
    assert_equal "Portishead", @album.artist_name
  end
  
  test "can get album release date" do
    assert_equal "    2 Feb 2005", @album.release_date
  end
  
  test "can get album image url" do
    assert_equal "http://userserve-ak.last.fm/serve/300x300/9485831.jpg", @album.image_url
  end
  
  test "can get album description" do
    expected = "Dummy is the 1994 debut album of the Bristol-based group Portishead. " +
      "It reached #2 on the UK Album Chart and #79 on the Billboard 200 chart, going gold in 1997.  " +
      "Building on the promise of their earlier EP—&quot;Numb&quot;—it helped to cement the reputation " + 
      "of Bristol as the capital of Trip hop, a nascent genre which was then often referred to simply as " + 
      "&quot;the Bristol sound&quot;.The cover is a still of Gibbons from the short film that the band " +
      "created—To Kill a Dead Man—which originally got them signed due to their self composed soundtrack. "
    assert_equal expected, @album.description
  end
  
  test "favorite" do
    assert @album.is_favorite_of(1)
    assert !@album.is_favorite_of(2)
  end
end
