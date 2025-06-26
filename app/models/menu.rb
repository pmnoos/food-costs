class Menu < ApplicationRecord
  belongs_to :user
  has_many :menu_recipes, dependent: :destroy
  has_many :recipes, through: :menu_recipes
  
  # Image uploads
  has_one_attached :image

  validates :name, presence: true
  validates :occasion, presence: true
  validates :date, presence: true

  # Occasion types (same as Recipe for consistency)
  OCCASIONS = [
    'Anniversary', 'Birthday', 'Valentine\'s Day', 'Christmas', 
    'Thanksgiving', 'Easter', 'Halloween', 'New Year', 
    'Wedding', 'Graduation', 'Mother\'s Day', 'Father\'s Day',
    'Date Night', 'Family Dinner', 'Party', 'Picnic', 'BBQ',
    'Weekend Brunch', 'Weeknight Dinner', 'Holiday Feast'
  ].freeze

  scope :by_occasion, ->(occasion) { where(occasion: occasion) }
  scope :upcoming, -> { where('date >= ?', Date.current) }
  scope :past, -> { where('date < ?', Date.current) }
end 