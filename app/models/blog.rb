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
  
  #タグ検索、存在するタグネームがひとつでもあった場合はcurrent_tagsに代入
  def save_blogs(tags)
   current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
   old_tags = current_tags - tags
   new_tags = tags - current_tags

   # Destroy
   old_tags.each do |old_name|
     self.tags.delete Tag.find_by(tagname:old_name)
   end

   # Create
   new_tags.each do |new_name|
     blog_tag = Tag.find_or_create_by(tagname:new_name)
     self.tags << blog_tag
   end
  end
  
end
