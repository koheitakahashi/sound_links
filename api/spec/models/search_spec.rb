# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Search, type: :model do
  describe 'validates' do
    let(:search) { FactoryBot.build(:search, keyword: keyword) }

    describe 'keyword' do
      describe 'presence' do
        context 'blank ではない場合' do
          let(:keyword) { 'リライト' }
          it { expect(search).to be_valid }
        end

        context 'blank の場合' do
          let(:keyword) { '' }
          it { expect(search).to be_invalid }
        end
      end

      describe 'uniqueness' do
        context '他に同じ keyword が保存されていない場合' do
          let(:keyword) { '遥か彼方' }
          it { expect(search).to be_valid }
        end

        context '他に同じ keyword が登録されている場合' do
          let(:keyword) { '遥か彼方' }

          it 'invalid になる' do
            create(:search, keyword: '遥か彼方')
            expect(search).to be_invalid
          end
        end
      end
    end
  end
end
