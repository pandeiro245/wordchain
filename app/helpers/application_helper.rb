module ApplicationHelper
  def word_link_to(word)
    if word.title.match(/^https?:/)
      link_to word.title, word.title, target: '_blank'
    else
      # link_to word.title, word_path(word)
      link_to "#{word.title}(#{word.child_count})", word_path(word)
      # link_to "#{word.title}(#{word.total_count})", word_path(word)
    end
  end
end
