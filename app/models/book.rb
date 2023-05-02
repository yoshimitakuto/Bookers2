class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_image
  has_many :favorites, dependent: :destroy
  has_many :favorited_users, through: :favorites, source: :user

  #コメント機能
  has_many :book_comments, dependent: :destroy

  #閲覧数
  has_many :view_counts, dependent: :destroy

  #タグ機能
  has_many :book_tag_relations, dependent: :destroy
  has_many :tags, through: :book_tag_relations
  # accepts_nested_attributes_for :book_tag_relations, allow_destroy: true
  # accepts_nested_attributes_for :tags

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }

 def favorited_by?(user)
    favorites.exists?(user_id: user.id)
 end

 #スコープ機能を駆使して「今日・機能・今週・先週」のデータを取り出すための記述をモデルに行い、コントローラでの記述をすっきりさせる。（2日前〜6日前までも含む）
 scope :created_today, -> { where(created_at: Time.zone.now.all_day) }
 scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) }
 scope :created_2days, -> { where(created_at: 2.day.ago.all_day)}
 scope :created_3days, -> { where(created_at: 3.day.ago.all_day)}
 scope :created_4days, -> { where(created_at: 4.day.ago.all_day)}
 scope :created_5days, -> { where(created_at: 5.day.ago.all_day)}
 scope :created_6days, -> { where(created_at: 6.day.ago.all_day)}
 scope :created_this_week, -> { where(created_at: 6.day.ago.beginning_of_day..Time.zone.now.end_of_day) }
 scope :created_last_week, -> { where(created_at: 2.week.ago.beginning_of_day..1.week.ago.end_of_day) }

 scope :latest, -> { order(created_at: :desc) }
 scope :star_count, -> { order(star: :desc) }

end
