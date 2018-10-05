FactoryBot.define do
  factory :conditions do
    session
    tide { {
      position: {
        basic: ['low', 'mid', 'high'],
        advanced: {
          from: 6,
          to: 12
        }
      },
      movement: ['rising', 'slack', 'dropping'],
      size: {
        basic: ['small', 'medium', 'large'],
        advanced: 12
      }
    } }

    wave { {
      min_period: 10,
      direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
      min_height: 10,
      max_height: 100
    } }

    wind { {
      direction: ['n', 'ne', 'e', 'se', 's', 'sw', 'w', 'nw'],
      speed: ['<5', '<10', '<15', '<20', '<30', '<40']
    } }
  end
end
