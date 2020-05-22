class Sub < ApplicationRecord

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :moderator_id, presence: true

  belongs_to :moderator,
             class_name: 'User'

end
