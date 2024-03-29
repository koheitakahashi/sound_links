# frozen_string_literal: true

module WebmockKkboxHelper
  WebMock.enable!

  def mock_kkbox_search_results
    stub_request(:post, 'https://account.kkbox.com/oauth2/token')
      .with(
        body: {
          client_id: Rails.application.credentials.kkbox[:client_id],
          client_secret: Rails.application.credentials.kkbox[:client_secret],
          grant_type: 'client_credentials'
        })
      .to_return(status: 200, body: file_fixture('kkbox_api_response_when_authentication.json'))

    stub_request(:get, 'https://api.kkbox.com/v1.1/search?limit=25&offset=0&q=リライト&territory=JP&type=track')
      .with(
        headers: {
          'Authorization' => 'Bearer {NEW_ACCESS_TOKEN}',
        })
      .to_return(status: 200, body: file_fixture('kkbox_api_response_when_search_rewrite.json'), headers: {})
  end

  def mock_kkbox_search_results_without_page
    stub_request(:post, 'https://account.kkbox.com/oauth2/token')
      .with(
        body: {
          client_id: Rails.application.credentials.kkbox[:client_id],
          client_secret: Rails.application.credentials.kkbox[:client_secret],
          grant_type: 'client_credentials'
        })
      .to_return(status: 200, body: file_fixture('kkbox_api_response_when_authentication.json'))

    stub_request(:get, 'https://api.kkbox.com/v1.1/search?limit=25&offset=0&q=リライト&territory=JP&type=track')
      .with(
        headers: {
          'Authorization' => 'Bearer {NEW_ACCESS_TOKEN}',
        })
      .to_return(status: 200, body: file_fixture('kkbox_api_response_when_search_rewrite.json'), headers: {})
  end

  def mock_kkbox_search_when_no_results
    stub_request(:post, 'https://account.kkbox.com/oauth2/token')
      .with(
        body: {
          client_id: Rails.application.credentials.kkbox[:client_id],
          client_secret: Rails.application.credentials.kkbox[:client_secret],
          grant_type: 'client_credentials'
        })
      .to_return(status: 200, body: file_fixture('kkbox_api_response_when_authentication.json'))

    stub_request(:get, 'https://api.kkbox.com/v1.1/search?limit=25&offset=0&q=検索結果なし&territory=JP&type=track')
      .with(
        headers: {
          'Authorization' => 'Bearer {NEW_ACCESS_TOKEN}',
        })
      .to_return(status: 200,
                 body: '{ "tracks": { "data": [] } }',
                 headers: {})
  end

  def mock_kkbox_authentication_error_response
    stub_request(:post, 'https://account.kkbox.com/oauth2/token')
      .with(
        body: {
          client_id: Rails.application.credentials.kkbox[:client_id],
          client_secret: Rails.application.credentials.kkbox[:client_secret],
          grant_type: 'client_credentials'
        })
      .to_return(status: 401, body: file_fixture('kkbox_api_response_when_authentication_error.json'))

    stub_request(:get, 'https://api.kkbox.com/v1.1/search?limit=25&offset-0&q=bad_params&territory=JP&type=track')
      .to_return(status: 200, body: file_fixture('kkbox_api_response_when_search_rewrite.json'), headers: {})
  end
end
