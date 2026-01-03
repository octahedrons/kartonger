class BoxFilesController < ApplicationController
  def show
    @box_file = BoxFile.find(params[:id])
    disposition = params[:download] ? "attachment" : "inline"
    send_data @box_file.data,
              filename: @box_file.filename,
              type: @box_file.content_type,
              disposition: disposition
  end

  def destroy
    @box = Box.find(params[:box_id])
    @box_file = @box.box_files.find(params[:id])
    @box_file.destroy
    redirect_to edit_box_path(@box), notice: "Filen har tagits bort"
  end
end
