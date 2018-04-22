class UsersController < ApplicationController
  def show
    @word = Word.find(1)
    render 'words/show'
  end

  def callback
    data = request.env['omniauth.auth']

    twitter_id = data['uid']

    user = User.find_or_create_by(
      twitter_id: twitter_id
    )
    user.image_url =  data['info']['image']

    if user.words.count == 0
      word = Word.create!(
        title: data['info']['name'],
        user: user
      )
      user.word = word
    end
    user.save!

    cookies[:user_id] = user.id
    redirect_to word_path(Word.last)
  end
end
