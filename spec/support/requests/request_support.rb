module Hello::RequestSupport

  def then_I_should_get_a_response(i, s)
    Then "I should get a #{i} '#{s}' response" do
      expect(response.status).to eq(i)
      expect(response.status_message).to eq(s)
    end
  end

end
