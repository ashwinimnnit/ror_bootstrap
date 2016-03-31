# Talentica - bootstrap project
# Copyright   Ashwini Kumar
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user!
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = current_user
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  def admin_add_members
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
  end

  # GET /profiles/1/edit
  def edit
  end

  def update_profile_image
    id = params[:user][:attr].to_i
    @user = User.find(id)
    @response = @user.update_attribute(:avatar, params[:user][:avatar])
    respond_to do |format|
      format.json { render json: @response }
    end
  end
  # POST /profiles
  # POST /profiles.json

  def create
    @profile = Profile.new(profile_params)
    respond_to do |format|
      if @profile.save
        format.html do
          redirect_to @profile, notice:
          'Profile was successfully created.'
        end
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json do
          render json: @profile.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html do
          redirect_to @profile,
                      notice: 'Profile was successfully updated.'
        end
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json do
          render json: @profile.errors,
                 status: :unprocessable_entity
        end
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html do
        redirect_to profiles_url, notice:
                                 'Profile was successfully destroyed.'
      end
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.find_by_id(params[:id])
    @user = User.find_by_id(@profile.user_id)
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def profile_params
    params.require(:profile).permit(:fname, :lname)
  end
end
