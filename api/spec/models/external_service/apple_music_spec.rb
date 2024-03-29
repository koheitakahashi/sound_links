# frozen_string_literal: true

require 'rails_helper'

module ExternalService
  RSpec.describe AppleMusic, type: :model do
    let(:apple_music) { described_class.new(keyword: keyword) }
    let(:keyword) { 'リライト' }

    describe '.search' do
      before '#search が呼ばれることのみを検証するためにスタブしている' do
        allow(described_class).to receive(:new).and_return(apple_music)
        allow(apple_music).to receive(:search).and_return(true)
      end

      it '#search が呼ばれる' do
        described_class.search(keyword: '遥か彼方')
        expect(apple_music).to have_received(:search)
      end
    end

    describe '#search' do
      context '引数に1単語が与えられた場合' do
        before do
          mock_apple_music_search_results
        end

        subject(:result) { apple_music.search.first }

        it { expect(result[:isrc]).to eq 'JPKS00400641' }
        it { expect(result[:thumbnail_url]).to eq 'https://is5-ssl.mzstatic.com/image/thumb/Music/v4/33/a3/42/33a342ac-ae02-91c4-4816-28c181b5284b/jacket_KSCL01917B01A_600over.jpg/300x300bb.jpeg' }
        it { expect(result[:title]).to eq 'リライト' }
        it { expect(result[:artist]).to eq 'ASIAN KUNG-FU GENERATION' }
        it { expect(result[:apple_music_url]).to eq 'https://music.apple.com/jp/album/%E3%83%AA%E3%83%A9%E3%82%A4%E3%83%88/570003767?i=570003920' }
      end

      context '引数に空文字が与えられた場合' do
        let(:keyword) { '' }
        it { expect(apple_music.search).to eq [] }
      end

      context '外部APIからエラーレスポンスが返ってきた場合' do
        let(:keyword) { 'bad_params' }
        before do
          mock_apple_music_error_response
        end

        it ' ExternalService::Errorが raise される' do
          expect { apple_music.search }.to raise_error { |error|
            expect(error.message).to eq 'There was an error connecting with the AppleMusic API. HTTP Status Code: 401, Error message: No token provided, No token provided' }
        end
      end
    end
  end
end
