class Blog < ApplicationRecord
  has_one_attached :image, dependent: :destroy
  belongs_to :user
  
  #投稿とユーザーidの紐付け
  def user
    return User.find_by(id: self.user_id)
  end
  
end
