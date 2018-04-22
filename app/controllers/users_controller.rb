class UsersController < ApplicationController
  def show
    @word = Word.find(1)
    render 'words/show'
  end
end
