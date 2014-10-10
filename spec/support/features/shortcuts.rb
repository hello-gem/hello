
def json_response
  JSON(response.body)
end

def response_status
  [response.status, response.status_message]
end