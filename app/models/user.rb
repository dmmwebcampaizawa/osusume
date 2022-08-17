class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one_attached :profile_image, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

 has_many :blogs, dependent: :destroy
 has_many :comments, dependent: :destroy

# 退会済みのユーザーが同じアカウントでログイン出来ないよう制約
  def active_for_authentication?
    super && (is_deleted == false)
  end

  #ゲストユーザー
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # user.confirmed_at = Time.now  # Confirmable を使用している場合は必要
    end
  end

  # 投稿一覧でユーザーと投稿を紐付ける
  def blogs
    return Blog.where(user_id: self.id)
  end

end
