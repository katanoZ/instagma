module PicturesHelper

require 'flickraw'
Dotenv.load
FlickRaw.api_key = ENV["FLICKER_API_KEY"]
FlickRaw.shared_secret = ENV["FLICKER_API_SECRET"]
#FlickRaw.api_key = "FLICKER_API_KEY"
#FlickRaw.shared_secret = "FLICKER_API_SECRET"

  def flicker_urls
  # tag:  検索タグ。
  # sort: ソート順。デフォルトは「date-posted-desc」。
  #       「relevance」は関連度の高さでソート。
  # per_page: 検索した時の取得件数。デフォルトは100件。

    word = "くま" # 検索タグ
    images = flickr.photos.search(tags: word, sort: "relevance", per_page: 10)
=begin
    images.each do |image|
      info = flickr.photos.getInfo :photo_id => image.id, :secret => image.secret
      sizes = flickr.photos.getSizes :photo_id => image.id
      size_list = sizes.map{ |size| "(#{ size.width } : #{ size.height })"}.join(", ")
      posted = Time.at(info.dates.posted.to_i).to_s
      url = FlickRaw.url image
      tags = info.tags
      tag_list = tags.map{ |tag| "#{ tag }" }.join(", ")
      puts "【タイトル】" + image.title
      puts "【URL】" + url
      puts "【投稿者】"+ info.owner.username
      puts "【投稿日】: " + posted
      puts "【出力可能サイズ(横:縦)】" + size_list
      puts "【説明】" + info.description
      puts "【タグ】" + tag_list
    end
=end
    urls = []
    images.each do |image|
      url = FlickRaw.url image
      urls << url
    end
    return urls
  end

end
