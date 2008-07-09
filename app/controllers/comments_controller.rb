# redMine - project management software
# Copyright (C) 2006-2008  Jean-Philippe Lang
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
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

class CommentsController < ApplicationController
  layout 'base'
  before_filter :find_comment

  def edit
    if request.post?
      @comment.update_attributes(:comments => params[:comments]) if params[:comments]
      @comment.destroy if @comment.comments.blank?
      respond_to do |format|
        format.html { redirect_to :controller => 'wiki', :action => 'show', :id => @comment.commented_id }
        format.js   { render :action => 'update' }
      end
    end
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
    render_403 and return false unless @comment.editable_by?(User.current)
  rescue ActiveRecord::RecordNotFound
    render_404
  end
  
end