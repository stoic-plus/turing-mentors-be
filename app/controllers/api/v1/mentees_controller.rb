class Api::V1::MenteesController < ApplicationController
  def create
    mentee = User.new_mentee(mentee_params)
    if mentee.save
      User.create_mentee_info(mentee_params, mentee)
      render json: MenteeSerializer.new(mentee), status: 200
    else
      render json: { message: "incorrect user information supplied"}, status: 400
    end
  end

  def update
    mentee = User.find(params[:id])
    if mentee
      mentee_params.each do |attribute, value|
        next unless value
        if contact_attribute?(attribute)
          update_contact(mentee.id, attribute, value)
        elsif attribute == "availability"
          update_availability(mentee.id, attribute, value)
        elsif attribute == "identities"
          current_identities = mentee.identities.pluck(:id)
          value.each do |identity|
            unless current_identities.include?(identity.to_i)
              UserIdentity.create(user_id: mentee.id, identity_id: identity.to_i)
            end
          end
        else
          value = value.to_i if attribute == "cohort"
          mentee.update(attribute.to_sym => value)
        end
      end
      render json: MentorSerializer.new(mentee), status: 200
    else

    end
  end

  private

  def update_availability(mentee_id, attribute, value)
    value.each do |day_of_week, availability|
      new_availability = {}
      new_availability[:day_of_week] = day_of_week
      if availability.class == Array
          new_availability[:morning] = availability[0],
          new_availability[:afternoon] = availability[1],
          new_availability[:evening] = availability[2]
      else
          new_availability[:morning] = availability,
          new_availability[:afternoon] = availability,
          new_availability[:evening] = availability
      end
      Availability.find_by(user: mentee_id).update(new_availability)
    end
  end

  def contact_attribute?(attribute)
    return true if attribute == "phone"
    return true if attribute == "slack"
    return true if attribute == "email"
    false
  end

  def update_contact(mentee_id, attribute, value)
    ContactDetails.find_by(user: mentee_id).update(attribute.to_sym => value)
  end

  def mentee_params
    params.permit(
    :background,
    :cohort,
    :program,
    :email,
    :first_name,
    :last_name,
    :phone,
    :slack,
    :identities => [],
    :availability => {}
  )
  end
end
