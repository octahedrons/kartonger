class BoxesController < ApplicationController
  def index
    @boxes = Box.preload(:actions).order(number: :desc)
    @unpack_count = @boxes.count(&:unpacked?)
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
    @box = Box.includes(:box_files).find(params[:id])
  end

  def new
    @box = Box.new
    @next_number = Box.next_number
  end

  def create
    @box = Box.new(box_params.except(:files))

    if @box.save
      attach_files
      redirect_to boxes_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @box = Box.includes(:box_files).find(params[:id])
  end

  def update
    @box = Box.find(params[:id])

    if @box.update(box_params.except(:files))
      attach_files
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
    params.require(:box).permit(:number, :room, :title, :description, :packed_by, files: [])
  end

  def attach_files
    return unless params[:box][:files]

    params[:box][:files].each do |file|
      next if file.blank?

      @box.box_files.create!(
        filename: file.original_filename,
        content_type: file.content_type,
        data: file.read
      )
    end
  end
end
