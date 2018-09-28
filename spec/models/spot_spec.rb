require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'create new spot' do
    context 'with all attributes' do
      it 'Should add new spot to db' do
        user = FactoryBot.create(:user)
        spot = user.spots.create(
          name: 'Hardies Bay',
          wave_break_type: 'beach',
          wave_shape: ['crumbling', 'steep'],
          wave_length: ['short', 'average'],
          wave_speed: ['slow', 'average'],
          wave_direction: ['left', 'right']
        )
        expect(spot.persisted?).to eq(true)
        expect(user.spots.count).to eq(1)
      end
    end

    context 'cannot be created without user' do
      it 'Should not add spot to db' do
        spot = Spot.create(
          name: 'Hardies Bay',
          wave_break_type: 'beach',
          wave_shape: ['crumbling', 'steep'],
          wave_length: ['short', 'average'],
          wave_speed: ['slow', 'average'],
          wave_direction: ['left', 'right']
        )
        expect(spot.persisted?).to eq(false)
        expect(Spot.count).to eq(0)
      end
    end

  end
end

# surf_conditions: [
#   {
#     board_type: ['shortboard'],
#     good: {
#       conditions: {
#         tide: {
#           position: {
#             basic: ['low', 'mid']
#           },
#           movement: ['rising'],
#           size: {
#             basic: ['medium'],
#           }
#         },
#         wind: {
#           good: {
#             direction: ['e', 'se'],
#             speed: ['<10']
#           }
#         },
#         wave: {
#           min_period: 10,
#           direction: ['s', 'sw', 'w', 'nw'],
#           min_height: 1
#         }
#       }
#     },
#     average: {
#       conditions: {
#         tide: {
#           position: {
#             basic: ['low', 'mid']
#           },
#           movement: ['rising'],
#           size: {
#             basic: ['small', 'medium', 'large'],
#           }
#         },
#         wind: {
#           good: {
#             direction: ['e', 'se'],
#             speed: ['<20']
#           }
#         },
#         wave: {
#           min_period: 8,
#           direction: ['s', 'sw', 'w', 'nw'],
#           min_height: 0.6
#         }
#       }
#     }
#   }
