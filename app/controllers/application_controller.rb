class ApplicationController < ActionController::API
  def create_user(type, params)
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

  def update_user(type, id, params)
    user = User.find_by(id: id)
    if user
      if type == :mentor
        User.update_mentor(user, params)
        render json: MentorSerializer.new(user), status: 200
      elsif type == :mentee
        User.update_mentee(user, params)
        render json: MenteeSerializer.new(user), status: 200
      end
    else
      base = type == :mentor ? "mentor" : "mentee"
      render json: {"message" => "#{base} not found by that id"}, status: 404
    end
  end

  def destroy_user(type, id)
    user = User.find_by(id: id)
    if user
      User.destroy(user.id)
      render nothing: true, status: 204
    else
      base = type == :mentor ? "mentor" : "mentee"
      render json: {"message" => "#{base} not found by that id"}, status: 404
    end
  end
end
