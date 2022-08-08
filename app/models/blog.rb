class Blog < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :blog_tags, dependent: :destroy
  has_many :tags, through: :blog_tags

  #投稿とユーザーidの紐付け
  def user
    return User.find_by(id: self.user_id)
  end

#   カラムの中から同じ値がないか探して、あればそのまま、なければ新たにカラムに保存します。
    def save_tags(saveblog_tags)
        current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
        old_tags = current_tags - saveblog_tags
        new_tags = saveblog_tags - current_tags

        old_tags.each do |old_tagname|
        self.tags.delete Tag.find_by(tagname: old_tagname)
        end

        new_tags.each do |new_tagname|
        blog_tag = Tag.find_or_create_by(tagname: new_tagname)
        self.tags << blog_tag
        end
    end
end
