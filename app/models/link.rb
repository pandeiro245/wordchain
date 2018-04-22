class Link < ApplicationRecord
  belongs_to :parent, class_name: 'Word', foreign_key: 'parent_word_id', optional: true
  belongs_to :child, class_name: 'Word', foreign_key: 'child_word_id', optional: true
end
