FactoryBot.define do
  factory :tide do
    high { [{:time=>" 8:16", :height=>9.86}, {:time=>"20:40", :height=>9.66}] }
    low { [{:time=>" 1:57", :height=>1.37}, {:time=>"14:18", :height=>1.56}] }
    size { "massive" }
  end
end
