class Api::V1::MentorsController < ApplicationController
  def index
    mentors = User.all
    render json: UserSerializer.new(mentors), status: 200
  end
end
