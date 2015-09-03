
def json_response
  JSON(response.body)
end

def response_status
  [response.status, response.status_message]
end

def show_me
  save_and_open_page
end

def page_reload
  visit current_url
end

def click_nth_button(string, i)
  page.all(:button, string)[i].click
end

def mock_stateless!
  allow_any_instance_of(Hello::Manager::RequestManagerFactory).to receive(:is_stateless?).and_return(true)
end