module WaitForAjax
  def wait_for_ajax
    # Wait for first request if not already done
    begin
      Timeout.timeout(0.2) do
        loop while finished_all_ajax_requests?
      end
    rescue
    end

    # Wait for all AJAX requests to complete
    begin
      Timeout.timeout(Capybara.default_max_wait_time) do
        loop until finished_all_ajax_requests?
        sleep AJAX_COMPLETE_WAIT
      end
    rescue
    end
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end
