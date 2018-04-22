class Word < ApplicationRecord
  attr_accessor :parent_title, :child_title
  belongs_to :user
  has_many :parent_links, class_name: 'Link', foreign_key: 'child_word_id'
  has_many :child_links, class_name: 'Link', foreign_key: 'parent_word_id'

  def own(user)
    Word.find_or_create_by(
      title: title,
      user: user
    )
  end

  def self.update_child_counts
    self.all.each do |word|
      word.update_child_count
    end
  end
  
  def update_child_count
    self.child_count = child_links.count
    self.save!
  end

  def parents
    parent_links.includes(:parent).map{|link| link.parent}.sort{|a, b| b.child_count <=> a.child_count}
  end

  def children
    child_links.includes(:child).map{|link| link.child}.sort{|a, b| b.child_count <=> a.child_count}
  end

  def total_count
    parent_count + child_count
  end

  def expand(params, user_id)
    if params[:parent_title].present?
      update_link('parent', params[:parent_title], user_id)
    end

    if params[:child_title].present?
      update_link('child', params[:child_title], user_id)
    end
    update(params)
  end

  def update_link(type, title, user_id)
    word = Word.find_or_create_by(
      title: title,
      user_id: user_id
    )
    case type
    when 'parent'
      parent_word_id = word.id
      child_word_id  = id
    when 'child'
      parent_word_id = id
      child_word_id  = word.id
    end
    Link.find_or_create_by(
      parent_word_id: parent_word_id,
      child_word_id: child_word_id
    )
  end

  def added_child
    return nil if child_title.blank?
    Word.find_or_create_by(
      title: child_title
    )
  end
end
