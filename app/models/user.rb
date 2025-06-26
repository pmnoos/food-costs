class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_many :recipes, dependent: :destroy
  has_many :menus, dependent: :destroy
  has_many :products, dependent: :destroy
  has_many :stores, dependent: :destroy
end
