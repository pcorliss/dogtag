class RacesController < ApplicationController
  before_filter :require_user, :except => [:index, :show]
  respond_to :html

  def index
    @races = Race.find_registerable_races
    @all_races = Race.all
  end

  def show
    @race = Race.find params[:id]
    respond_with @race
  rescue ActiveRecord::RecordNotFound
    flash[:error] = t('not_found')
    redirect_to races_path
  end

  alias edit show

  def new
    @race = Race.new
  end

  def create
    return render :status => 400 if params[:race].blank?

    @race = Race.new race_params
    if @race.save
      flash[:notice] = I18n.t('create_success')
      return redirect_to races_path
    else
      flash.now[:error] = [t('create_failed')]
      flash.now[:error] << @race.errors.messages
      respond_with @race
    end
  end

  def update
    @race = Race.find params[:id]
    if @race.update_attributes(race_params)
      flash[:notice] = t('update_success')
      return redirect_to races_path
    else
      flash[:error] = [t('update_failed')]
      flash[:error] << @race.errors.messages
      respond_with @race
    end
  rescue ActiveRecord::RecordNotFound
    flash.now[:error] = t('not_found')
    render :status => 400
  end

  def destroy
    @race = Race.find params[:id]
    return render :status => 400 if @race.nil?

    if @race.destroy
      flash[:notice] = t '.destroy_success'
    else
      flash[:error] = t '.destroy_failed'
    end
    redirect_to races_path
  rescue ActiveRecord::RecordNotFound
    render :status => 400
  end

  private

  def race_params
    params.require(:race).permit(:name, :max_teams, :people_per_team,
                                 :race_datetime, :registration_open, :registration_close)
  end

end
