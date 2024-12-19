class BoxesController < ApplicationController
  def index
    @boxes = Box.order(number: :desc).all
    @count_by_room = Box.group(:room).count.sort_by { _2 }.reverse.to_h

    respond_to do |format|
      format.html
      format.csv do
        filename = [ "boxes_", Time.now.utc.to_fs(:iso8601), ".csv" ].join
        headers["content-disposition"] = "attachment; filename=#{filename}"
        render csv: @boxes
      end
      format.db do
        database_path = ActiveRecord::Base.connection_db_config.database
        filename = filename = ["boxes_", Box.count, "_", Time.now.utc.to_fs(:iso8601), ".sqlite3"].join
        type = Mime::Type.lookup_by_extension(:db).to_s

        send_file(database_path, filename:, type:)
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
    params.require(:box).permit(:number, :room, :title, :description, :packed_by)
  end
end
