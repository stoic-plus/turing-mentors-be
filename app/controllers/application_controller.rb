class ApplicationController < ActionController::API
  def create_user(type)
    user = User.new_mentee(params) if type == :mentee
    user = User.new_mentor(params) if type == :mentor
    if user.save
      if type == :mentor
        User.create_mentor_info(params, user)
        render json: MentorSerializer.new(user), status: 200
      elsif type == :mentee
        User.create_mentee_info(params, user)
        render json: MenteeSerializer.new(user), status: 200
      end
    else
      render json: { message: "incorrect user information supplied"}, status: 400
    end
  end

  def update_user(type, params)

  end

  def destroy_user(type)

  end
end
