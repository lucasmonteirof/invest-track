require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    subject { post "/users", params: params }

    shared_examples "invalid user creation" do
      it "does not create a User in database" do
        expect { subject }.not_to change(User, :count)
      end

      it "responds with status unprocessable_entity" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with valid params" do
      let(:params) { { user: attributes_for(:user) } }

      it "creates a User in database" do
        expect { subject }.to change(User, :count).by(1)
      end

      it "responds status created" do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      context "login missing" do
        let(:params) { { user: attributes_for(:user).except(:login) } }

        it_behaves_like "invalid user creation"
      end

      context "password missing" do
        let(:params) { { user: attributes_for(:user).except(:password) } }

        it_behaves_like "invalid user creation"
      end

      context "name missing" do
        let(:params) { { user: attributes_for(:user).except(:name) } }

        it_behaves_like "invalid user creation"
      end

      context "date_of_birth missing" do
        let(:params) { { user: attributes_for(:user).except(:date_of_birth) } }

        it_behaves_like "invalid user creation"
      end

      context "existing login" do
        before do
          create(:user, login: "johndoe")
        end

        let(:params) { { user: attributes_for(:user).merge(login: "johndoe") } }

        it_behaves_like "invalid user creation"

        it "renders template :new" do
          subject
          expect(response.body).to include("Login has already been taken")
        end
      end
    end
  end
end
