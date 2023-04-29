class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy

  #コメント機能
  has_many :book_comments, dependent: :destroy

# フォローをした、されたの関係
has_many :relationships, class_name: "Relationship", foreign_key: "following_id", dependent: :destroy
has_many :reverse_of_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy

# 一覧画面で使う
has_many :followings, through: :relationships, source: :follower
has_many :followers, through: :reverse_of_relationships, source: :following

#DM機能
has_many :entries, dependent: :destroy
has_many :messages, dependent: :destroy

#閲覧数
has_many :view_counts, dependent: :destroy

#グループ作成
has_many :group_users
has_many :groups, through: :group_users, dependent: :destroy

  has_one_attached :profile_image

  validates :name, uniqueness: true, length: { in: 2..20 }
  validates :introduction, length: { maximum: 50 }


  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join("app/assets/images/no_image.jpg")
      profile_image.attach(io: File.open(file_path), filename: "default-image.jpg", content_type: "image/jpeg")
    end
    profile_image.variant(resize_to_limit: [width, height]).processed
  end

  def self.guest
    find_or_create_by!(name: "guestuser" ,email: "guest@guest") do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "guestuser"
    end
  end

  def is_followed_by?(user)
    reverse_of_relationships.find_by(following_id: user.id).present?
  end

end
