class CategoriesController < ApplicationController

   def create
    @category = Category.new(params.require(:category).permit(:name))

    if @category.save
      flash[:notice] = "Category saved"
      redirect_to posts_path
    else
      render :new
    end
  end

  def new
    @category = Category.new
  end

  def show
    @category = Category.find(params[:id])
  end
end