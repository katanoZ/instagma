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
    kuma_names = %W(白くま 黒くま 野良くま こぐま 大隈重信 紳士的なくま 目つきの悪いくま ヒグマ 眠いくま 茶くま アメリカグマ ジャイアントパンダ 鬼熊 通りすがりのくま)
    kuma_words01 = %W(この画像は この人は あなたは くま会議で くまも歩けば 今日も一日 今日は いつものように この場所は この日はずっと 見れば見るほど よい画像なので この画像を見て そういえば 実を言うと)
    kuma_words02 = %W(たのしい ねむい おいしい おもしろい おそろしい かなしい うれしい おいしそう おなかがへった 踊りたい 食べたい 逃げたい 歌をうたう ダンスダンスダンス クマトルネード 冬眠する くまごはん 転がり続ける めでたい レッツ 毛皮が暑い ハングリー 満腹)
    kuma_words03 = %W|くま くま？ くま！ くまー くまっ くまーーー くまʕ•ᴥ•ʔ くま(ᵔᴥᵔ) くま(￣(工)￣) くまままま・・・ くまくま！ く、くまー|
    kuma_images = [asset_path("kuma00"), asset_path("kuma01"), asset_path("kuma02"), asset_path("kuma03"), asset_path("kuma04"), asset_path("kuma05"), asset_path("kuma06"), asset_path("kuma07"), asset_path("kuma08"), asset_path("kuma09"), asset_path("kuma10"), asset_path("kuma11"), asset_path("kuma12"), asset_path("kuma13")]

    random = Random.new
    kuma_number = random.rand(kuma_names.length)
    kuma_name = kuma_names[kuma_number]
    kuma_word = kuma_words01[random.rand(kuma_words01.length)] + kuma_words02[random.rand(kuma_words02.length)] + kuma_words03[random.rand(kuma_words03.length)]
    kuma_image = kuma_images[kuma_number]
    return_kuma = {name: kuma_name, word: kuma_word, image: kuma_image}
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

  def kuma_thumbnail(image, name)
    image_tag(image, alt: name, size: "55x55", class: "img-circle")
  end
end
