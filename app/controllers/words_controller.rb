class WordsController < ApplicationController
  before_action :set_word, only: [:show, :update]

  def show
  end

  def update
    current_user = User.find(cookies[:user_id])
    if @word.expand(word_params, cookies[:user_id])
      redirect_word = @word.id != current_user.word.id ? @word : @word.added_child
      redirect_to redirect_word, notice: 'Word was successfully updated.'
    else
      render :show
    end
  end

  private
    def set_word
      @word = Word.find(params[:id])
    end

    def word_params
      params.require(:word).permit(:title, :body, :parent_title, :child_title)
    end
end
