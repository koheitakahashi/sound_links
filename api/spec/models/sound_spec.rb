# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sound, type: :model do
  describe 'validates' do
    describe 'title' do
      let(:sound) { FactoryBot.build(:sound, title: title) }

      describe 'presence' do
        context 'blank ではない場合' do
          let(:title) { 'リライト' }
          it { expect(sound).to be_valid }
        end

        context 'blank の場合' do
          let(:title) { '' }
          it { expect(sound).to be_invalid }
        end
      end
    end

    describe 'artist' do
      let(:sound) { FactoryBot.build(:sound, artist: artist) }

      describe 'presence' do
        context 'blank ではない場合' do
          let(:artist) { 'ASIAN KUNG-FU GENERATION' }
          it { expect(sound).to be_valid }
        end

        context 'blank の場合' do
          let(:artist) { '' }
          it { expect(sound).to be_invalid }
        end
      end
    end

    describe '#attributes_exclude' do
      let!(:sound) { FactoryBot.create(:sound) }

      context '引数が1つの場合' do
        it '引数の attribute 以外の attributes が返る' do
          expected = {
            'isrc' => 'JPU901700684',
            'thumbnail_url' => 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
            'title' => '荒野を歩け',
            'artist' => 'ASIAN KUNG-FU GENERATION',
            'spotify_url' => 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
            'apple_music_url' => 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
            'kkbox_url' => 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
            'search_id' => sound.search_id,
            'created_at' => sound.created_at,
            'updated_at' => sound.updated_at
          }

          expect(sound.attributes_exclude(:id)).to eq expected
        end
      end

      context '引数が複数の場合' do
        it '引数の attribute 以外の attributes が返る' do
          expected = {
            'isrc' => 'JPU901700684',
            'thumbnail_url' => 'https://is3-ssl.mzstatic.com/image/thumb/Music124/v4/5a/6f/de/5a6fdeff-ba89-e6c4-dd0f-982481264c46/jacket_KSXX01381B00Z_550.jpg/300x300bb.jpeg',
            'title' => '荒野を歩け',
            'artist' => 'ASIAN KUNG-FU GENERATION',
            'spotify_url' => 'https://open.spotify.com/track/52q1x282D5DvSVNxJZHQPB',
            'apple_music_url' => 'https://music.apple.com/jp/album/%E8%8D%92%E9%87%8E%E3%82%92%E6%AD%A9%E3%81%91/1536495860?i=1536495861',
            'kkbox_url' => 'https://www.kkbox.com/jp/ja/song/uKa00E1MM52Mjf7iMjf7i0XL-index.html',
            'created_at' => sound.created_at,
            'updated_at' => sound.updated_at
          }

          expect(sound.attributes_exclude(:id, :search_id)).to eq expected
        end
      end
    end
  end
end
