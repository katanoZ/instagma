module PicturesHelper

require 'flickraw'
Dotenv.load
FlickRaw.api_key = ENV["FLICKER_API_KEY"]
FlickRaw.shared_secret = ENV["FLICKER_API_SECRET"]

  def flicker_images
  # tag:  検索タグ。
  # sort: ソート順。デフォルトは「date-posted-desc」。
  #       「relevance」は関連度の高さでソート。
  # per_page: 検索した時の取得件数。デフォルトは100件。

    word = "くま, クマ, 熊, bear" # 検索タグ
    random = Random.new
    images = flickr.photos.search(tags: word, sort: "relevance", per_page: 100, tag_mode: "all")
    select_images = []
    select_pages = random.rand(1..5)
    select_pages.times do
      select_images << images[random.rand(images.length)]
    end
    return select_images

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
    urls = []
    select_images.each do |image|
      url = FlickRaw.url image
      urls << url
    end
    return urls
=end
  end

  def kuma
    kuma_names = %W(白くま 黒くま 野良くま こぐま 大隈重信 ツキノワグマ グリズリー ヒグマ マレーグマ メガネグマ アメリカグマ ナマケグマ ジャイアントパンダ 鬼熊 通りすがりのくま)
    kuma_words01 = %W(この画像は この人は あなたは くま会議で くまも歩けば 今日も一日 今日は いつものように この場所は この日はずっと 見れば見るほど よい画像なので この画像を見て)
    kuma_words02 = %W(たのしい ねむい おいしい おもしろい おそろしい かなしい うれしい おいしそう おなかがへった 踊りたい 食べたい 逃げたい 歌をうたう ダンスダンスダンス クマトルネード 冬眠する くまごはん 転がり続ける)
    kuma_words03 = %W|くま くま？ くま！ くまー くまっ くまーーー くまʕ•ᴥ•ʔ くま(ᵔᴥᵔ) くま(￣(工)￣) くまままま・・・ くまくま！ く、くまー|

    random = Random.new
    kuma_name = kuma_names[random.rand(kuma_names.length)]
    kuma_word = kuma_words01[random.rand(kuma_words01.length)] + kuma_words02[random.rand(kuma_words02.length)] + kuma_words03[random.rand(kuma_words03.length)]
    return_kuma = {name: kuma_name, word: kuma_word}
  end

  def profile_img(user, size = "")

    if user.avatar?
      case size
      when "small"
        return image_tag(user.avatar, alt: user.name, size: "55x55", class: "img-circle")
      else
        return image_tag(user.avatar, alt: user.name)
      end
    end

    unless user.provider.blank?
      image_url = user.image_url
    else
      image_url = "no_image.png"
    end

    case size
    when "small"
      image_tag(image_url, alt: user.name, size: "55x55", class: "img-circle")
    else
      image_tag(image_url, alt: user.name)
    end
  end

end
