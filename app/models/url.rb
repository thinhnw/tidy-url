class Url < ApplicationRecord
  validates :original, presence: true,
            format: {
              with: /\A(http|https):\/\/[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(\/\S*)?\z/,
              message: "must be a valid URL" }
  validates :shortened, presence: true, uniqueness: true
end
