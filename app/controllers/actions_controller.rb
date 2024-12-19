class ActionsController < ApplicationController
  def index
    @actions = Action.order(created_at: :desc)
  end

  def create
    @action = Action.new(create_params)

    if @action.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Action.destroy_by(destroy_params)

    redirect_to root_path, status: :see_other
  end

  private

  def create_params
    box_id, action_name, user = params.expect(:box_id, :action_name, :user)

    { box_id:, name: action_name, user: }
  end

  def destroy_params
    box_id, action_id = params.expect(:box_id, :id)

    { box_id:, id: action_id }
  end
end
