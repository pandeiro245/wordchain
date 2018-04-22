class User < ApplicationRecord
  belongs_to :word, required: false
  has_many :words
end
