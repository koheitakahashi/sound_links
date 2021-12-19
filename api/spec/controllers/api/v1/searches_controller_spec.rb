# frozen_string_literal: true

require "rails_helper"

module API
  module V1
    RSpec.describe "/api/v1/search", type: :request do
      context "リクエストヘッダーが意図したものでない場合" do
        context "Content-Type が「text/html」、X-Requested-By が「https://example.com」の場合" do
          it "ステータスコード 401 エラーが返る" do
            get "/api/v1/search", headers: { "Content-Type" => "text/html", "X-Requested-By" => "https://example.com" }

            parsed_response = JSON.parse(response.body)

            expect(response.status).to eq 401
            expect(parsed_response["errors"]["message"]).to eq "Request is inappropriate."
          end
        end

        context "Content-Type が「application/json」、X-Requested-By が「https://example.com」の場合" do
          it "ステータスコード 401 エラーが返る" do
            get "/api/v1/search", headers: { "Content-Type" => "application/json", "X-Requested-By" => "https://example.com" }

            parsed_response = JSON.parse(response.body)

            expect(response.status).to eq 401
            expect(parsed_response["errors"]["message"]).to eq "Request is inappropriate."
          end
        end

        context "Content-Type が空文字、X-Requested-By が空文字の場合" do
          it "ステータスコード 401 エラーが返る" do
            get "/api/v1/search"

            parsed_response = JSON.parse(response.body)

            expect(response.status).to eq 401
            expect(parsed_response["errors"]["message"]).to eq "Request is inappropriate."
          end
        end
      end

      context "リクエストヘッダーが意図したものである場合" do
        before do
          mock_spotify_search_results
          mock_apple_music_search_results
          mock_kkbox_search_results
        end

        it "ステータスコード 200 が返る" do
          get "/api/v1/search", headers: { "Content-Type" => "application/json", "X-Requested-By" => "https://sound-links.com" }

          expect(response.status).to eq 200
        end

        context "params[:keyword]が空の場合" do
          it "resultsが空配列が入ったレスポンスが返る" do
            get "/api/v1/search", params: { keyword: "" }, headers: { "Content-Type" => "application/json", "X-Requested-By" => "https://sound-links.com" }

            parsed_response = JSON.parse(response.body)

            expect(parsed_response["results"]).to eq []
          end
        end

        context "params[:keyword]が「リライト」の場合" do
          it "resultsに値が入ったレスポンスが返る" do
            get "/api/v1/search", params: { keyword: "リライト" }, headers: { "Content-Type" => "application/json", "X-Requested-By" => "https://sound-links.com" }

            parsed_response = JSON.parse(response.body)
            parsed_response_first_result = parsed_response["results"].first

            expect(parsed_response_first_result["title"]).to eq "リライト"
            expect(parsed_response_first_result["artist"]).to eq "ASIAN KUNG-FU GENERATION"
            expect(parsed_response_first_result["isrc"]).to eq "JPKS00400641"
            expect(parsed_response_first_result["spotifyUrl"]).to eq "https://open.spotify.com/track/3h5e4tpgR9q0cjQXzo8FMD?si=WN7JPlJ5SuSQhrhh9Z-8Yw"
            expect(parsed_response_first_result["appleMusicUrl"]).to eq "https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920"
            expect(parsed_response_first_result["kkboxUrl"]).to eq "https://www.kkbox.com/jp/ja/song/FcqGD-90I.n6HlVI7lVI70P4-index.html"
            expect(parsed_response_first_result["thumbnailUrl"]).to eq "https://i.scdn.co/image/ab67616d00001e02fa355dc948984a72010ff83e"

            expect(parsed_response["currentPage"]).to eq 1
          end
        end
      end
    end
  end
end
