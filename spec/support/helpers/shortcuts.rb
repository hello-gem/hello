
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