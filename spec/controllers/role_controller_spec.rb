require 'rails_helper'

RSpec.describe RolesController, type: :controller do
  describe '#create' do
    context 'with valid params' do
      it 'should return created response' do
        post :create, params: { role: { name: 'logged user' } }

        expect(JSON.parse(response.body)['name']).to eq 'logged user'
        expect(response.status).to eq 201
      end
    end

    context 'with invalid params' do
      it 'should return unprocessable entity' do
        expect_any_instance_of(Role).to receive(:save).and_return false
        post :create, params: { role: { name: 'some invalid value' } }

        expect(response.status).to eq 422
      end
    end

    context 'with no params' do
      it 'should raise an error' do
        expect{ post :create, params: { role: { } } }.to raise_error ArgumentError
      end
    end
  end
end
