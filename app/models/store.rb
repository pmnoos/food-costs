class Store < ApplicationRecord
  belongs_to :user
  has_many :products, dependent: :destroy

  has_one_attached :logo do |attachable|
    attachable.variant :card, resize_to_limit: [ 160, 80 ], preprocessed: true
    attachable.variant :preview, resize_to_limit: [ 120, 120 ]
  end
end
