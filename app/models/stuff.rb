class Stuff < ApplicationRecord
    enum status: {open: 0, fullfilled: 1, dismissed: 2}  
    belongs_to :user
    belongs_to :category
    validates :stuff_name, :status, :category, presence: true
end