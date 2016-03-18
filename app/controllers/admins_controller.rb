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
class AdminsController < ApplicationController
  before_action :check_if_admin
  # before_filter :new ,:only => [:add_members]
  # execute new before add_members

  # listing of all admin activites
  def index
  end

  # for admin to add members custom action
  def new
    @user = User.new
  end

  def admin_assign_roles
    if params.key?('users') && params.key?('user')
      if params['user'].key?('roles')
        @message = Role.bulk_assignment_roles params
      end
    end
    redirect_to(action: 'index')
  end

  # send parameters to user model to create a new user by admin
  def add_members
    @response = User.from_admin params
    if @response.is_a?(User)
      redirect_to({ action: 'new' }, notice:
                    'user created')
    elsif @response.is_a?(ActiveRecord::RecordInvalid)
      redirect_to({ action: 'new' }, notice:
                   @response.record.errors)
    end
  end

  def list
    @users = User.all
  end

  def users
    @user = User.listingUser(params['term'])
    respond_to do |format|
      format.json { render json: @user }
    end
  end

  def bulk_user_update
    unless (@changed_date = params['userchg'].to_a -
            params['userori'].to_a).empty?
      User.bulk_edit @changed_date
    end
    redirect_to(action: 'list')
  end

  def remove
    @user = User.find_by_id(params['key'])
    @user.destroy
    respond_to do |format|
      format.json { render json: @user }
    end
  end
end
