require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'send mail to a user' do

    context 'when a new user signs up' do
      it 'should send a sign up confirmation' do
        user = FactoryBot.create(:user)
        expect(ActionMailer::Base.deliveries.empty?).to be(false)

        email = ActionMailer::Base.deliveries.first
        expect(email['to'].value).to eq(user.email)
        expect(email.subject).to eq('Welcome to Saltydog!')
      end
    end

    

  end
end
