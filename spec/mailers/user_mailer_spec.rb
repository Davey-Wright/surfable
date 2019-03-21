require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'send mail to a user on' do
    context 'sign up' do
      it 'should send a sign up confirmation' do
        user = FactoryBot.create(:user)
        expect(ActionMailer::Base.deliveries.empty?).to be(false)

        email = ActionMailer::Base.deliveries.first
        expect(email['to'].value).to eq(user.email)
        expect(email.subject).to eq('Welcome to Saltydog!')
      end
    end

    context 'update' do
      it 'should send a update confirmation' do
        user = FactoryBot.create(:user)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        user.update_attributes(first_name: 'Douglas')
        expect(ActionMailer::Base.deliveries.count).to eq(2)
        email = ActionMailer::Base.deliveries.last
        expect(email.subject).to eq('Your account settings have been successfully updated')
      end
    end

    context 'update' do
      it 'should send a update confirmation' do
        user = FactoryBot.create(:user)
        expect(ActionMailer::Base.deliveries.count).to eq(1)
        user.destroy
        expect(ActionMailer::Base.deliveries.count).to eq(2)
        email = ActionMailer::Base.deliveries.last
        expect(email.subject).to eq('Your account has been successfully deleted')
      end
    end
  end
end
