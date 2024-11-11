class BoxesController < ApplicationController
  def index
    @boxes = Box.order(number: :desc).all

    respond_to do |format|
      format.html
      format.csv do
        filename = [ "boxes_", Time.now.utc.to_fs(:iso8601), ".csv" ].join
        headers["content-disposition"] = "attachment; filename=#{filename}"
        render csv: @boxes
      end
    end
  end

  def show
    @box = Box.find(params[:id])
  end

  def new
    @box = Box.new
    @next_number = Box.next_number
  end

  def create
    @box = Box.new(box_params)

    if @box.save
      redirect_to boxes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @box = Box.find(params[:id])
  end

  def update
    @box = Box.find(params[:id])

    if @box.update(box_params)
      redirect_to boxes_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @box = Box.find(params[:id])
    @box.destroy

    redirect_to root_path, status: :see_other
  end

  private

  def box_params
    params.require(:box).permit(:number, :room, :title, :description)
  end
end
