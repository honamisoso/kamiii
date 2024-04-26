class TagMap < ApplicationRecord
  # tag_mapsテーブルは、postsテーブルとtagsテーブルに属している
  belongs_to :post
  belongs_to :tag
end
