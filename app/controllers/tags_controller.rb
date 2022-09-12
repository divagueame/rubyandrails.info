class TagsController < ApplicationController
  before_action :set_tag, only: %i[show edit update destroy]

  def index
    @tags = Tag.all.order(:title)
    @random = Tag.where(id: Tag.pluck(:id).sample) 


    set_meta_tags title: "#{@tags.count} topics about Ruby & Ruby on Rails", description: "Choose one of the #{@tags.count} topics about Ruby, Ruby on Rails, OOP and more and find out in which books you can learn more about it.", keywords: "books, Ruby, Ruby on Rails, how to learn ruby, how to learn Ruby on Rails"
  end

  def new
    @tag = Tag.new
  end

  def create
    @tag = Tag.new tag_params
    if @tag.save
      redirect_to tags_path
    else
      render :new
    end
  end

  def show
    @tags = Tag.all.order(:title)
    @books = Book.joins(:tags).where(tags: { id: @tag })
    @courses = Course.joins(:tags).where(tags: { id: @tag })

    @random = Tag.where(id: Tag.pluck(:id).sample) 

    set_meta_tags title: "#{@books.count} books about #{@tag.title}", description: "#{@books.count} books about #{@tag.title}"
  end

  def edit
  end

  def update
    if @tag.update tag_params
      redirect_to tags_path
    else
      render :edit
    end
  end

  def destroy
    @tag.destroy
    redirect_to tags_path
  end

  private

  def set_tag
    @tag = Tag.friendly.find(params[:id])
  end

  def tag_params
    params.require(:tag).permit(:title)
  end
end
