class Url < ApplicationRecord
  validates :original, presence: true
  validates :shortened, presence: true, uniqueness: true
end
