class Word < ApplicationRecord
  attr_accessor :parent_title, :child_title
  belongs_to :user
  has_many :parent_links, class_name: 'Link', foreign_key: 'child_word_id'
  has_many :child_links, class_name: 'Link', foreign_key: 'parent_word_id'
  def parents
    parent_links.sort{|a, b| b.parent.child_count <=> a.parent.child_count}.map{|link| link.parent}
  end

  def children
    child_links.sort{|a, b| b.child.child_count <=> a.child.child_count}.map{|link| link.child}
  end

  def total_count
    parent_count + child_count
  end

  def parent_count
    parents.count
  end

  def child_count
    # children.count
    0
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
