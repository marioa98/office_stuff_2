class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :stuff
  
    validates :comment, presence: true
end