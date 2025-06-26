class Recipe < ApplicationRecord
  belongs_to :user
  has_many :menu_recipes, dependent: :destroy
  has_many :menus, through: :menu_recipes
  
  # Image uploads
  has_one_attached :image

  validates :name, presence: true
  validates :cuisine, presence: true
  validates :difficulty, presence: true

  # Cuisine options for world recipes
  CUISINES = [
    'Italian', 'Mexican', 'Chinese', 'Indian', 'Thai', 'Japanese', 
    'French', 'Mediterranean', 'Greek', 'Spanish', 'Moroccan', 
    'Turkish', 'Lebanese', 'Vietnamese', 'Korean', 'Ethiopian',
    'Brazilian', 'Peruvian', 'Argentinian', 'Caribbean', 'American',
    'British', 'German', 'Russian', 'Polish', 'Hungarian', 'Swedish'
  ].freeze

  # Difficulty levels
  DIFFICULTIES = ['Beginner', 'Intermediate', 'Advanced', 'Expert'].freeze

  # Occasion types
  OCCASIONS = [
    'Anniversary', 'Birthday', 'Valentine\'s Day', 'Christmas', 
    'Thanksgiving', 'Easter', 'Halloween', 'New Year', 
    'Wedding', 'Graduation', 'Mother\'s Day', 'Father\'s Day',
    'Date Night', 'Family Dinner', 'Party', 'Picnic', 'BBQ',
    'Weekend Brunch', 'Weeknight Dinner', 'Holiday Feast'
  ].freeze

  scope :by_cuisine, ->(cuisine) { where(cuisine: cuisine) }
  scope :by_occasion, ->(occasion) { where(occasion: occasion) }
  scope :by_difficulty, ->(difficulty) { where(difficulty: difficulty) }
end 