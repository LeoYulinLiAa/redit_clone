class Post < ApplicationRecord

  validates :title, presence: true
  validates :sub_id, presence: true
  validates :author_id, presence: true

  belongs_to :sub

  belongs_to :author,
             class_name: 'User'


end
