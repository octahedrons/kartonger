class BoxesController < ApplicationController
  def index
    @boxes = Box.all
  end

  def show
    @box = Box.find(params[:id])
  end

  def new
    @box = Box.new
  end

  def create
    @box = Box.new(box_params)

    if @box.save
      redirect_to boxes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def box_params
    params.require(:box).permit(:number, :room, :title, :description)
  end
end
