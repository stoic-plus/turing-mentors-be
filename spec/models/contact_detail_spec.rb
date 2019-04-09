require 'rails_helper'

describe ContactDetails, type: :model do
  describe 'validations' do
    it {should validate_presence_of(:preferred_method)}
  end

  describe 'class methods' do
    context 'for_user' do
      it 'creates a contact detail given contact information and a user' do
        user = User.create(first_name: 'Travis', last_name: ' Gee', cohort: 1810, program: 'FE', current_job: 'google', background: 'IT', mentor: true, location: 'Denver, CO')
        contact_info = {
          email: 'm@mail.com',
          slack: 'j@slack',
          phone: '720',
        }
        contact = ContactDetails.for_user(contact_info, user)
        expect(contact).to be_a(ContactDetails)
        expect(contact.email).to eq(contact_info[:email])
        expect(contact.slack).to eq(contact_info[:slack])
        expect(contact.phone).to eq(contact_info[:phone])
        expect(contact.user_id).to eq(user.id)
      end
    end
  end
end
