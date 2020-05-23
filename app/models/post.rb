class Post < ApplicationRecord

  validates :title, presence: true
  validates :author_id, presence: true

  has_many :post_subs

  has_many :subs,
           through: :post_subs,
           source: :sub

  belongs_to :author,
             class_name: 'User'


end
