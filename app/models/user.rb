class User < ActiveRecord::Base
  validates :name, presence: true
  validates :money, numericality: { only_integer: true }
end
