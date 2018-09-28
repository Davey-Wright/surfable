require 'rails_helper'

RSpec.describe Spot, type: :model do
  describe 'create new spot' do
    context 'basic spot' do
      Spot.create({
        name: 'Hardies Bay',
        wave_break_type: 'beach',
        wave_shape: ['crumbling', 'steep'],
        wave_length: ['short', 'average'],
        wave_speed: ['slow', 'average'],
        wave_direction: ['left', 'right'],
        surf_conditions: [
          {
            board_type: ['shortboard'],
            good: {
              conditions: {
                tide: {
                  position: {
                    basic: ['low', 'mid']
                  },
                  movement: ['rising'],
                  size: {
                    basic: ['medium'],
                  }
                },
                wind: {
                  good: {
                    direction: ['e', 'se'],
                    speed: ['<10']
                  }
                },
                wave: {
                  min_period: 10,
                  direction: ['s', 'sw', 'w', 'nw'],
                  min_height: 1
                }
              }
            },
            average: {
              conditions: {
                tide: {
                  position: {
                    basic: ['low', 'mid']
                  },
                  movement: ['rising'],
                  size: {
                    basic: ['small', 'medium', 'large'],
                  }
                },
                wind: {
                  good: {
                    direction: ['e', 'se'],
                    speed: ['<20']
                  }
                },
                wave: {
                  min_period: 8,
                  direction: ['s', 'sw', 'w', 'nw'],
                  min_height: 0.6
                }
              }
            }
          }
        ]
        })
    end
  end
    # context 'with advanced tidal conditions' do
    #
    # end
end
