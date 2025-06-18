require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users/new" do
    subject(:get_users) { get new_user_path }

    it "returns HTTP status :ok" do
      get_users
      expect(response).to have_http_status(:ok)
    end

    it "renders template :new" do
      get_users
      expect(response).to render_template(:new)
    end
  end

  describe "POST /users" do
    subject(:post_users) { post users_path, params: params }

    shared_examples "invalid user creation" do
      it "does not create a User in database" do
        expect { post_users }.not_to change(User, :count)
      end

      it "responds with status unprocessable_entity" do
        post_users
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with valid params" do
      let(:params) { { user: attributes_for(:user) } }

      it "creates a User in database" do
        expect { post_users }.to change(User, :count).by(1)
      end

      it "responds status created" do
        post_users
        expect(response).to have_http_status(:created)
      end

      it "does not persist :password" do
        post_users
        expect(User.last.password).to be_nil
      end

      it "digests the password" do
        post_users
        expect(User.last.password_digest).not_to be_nil
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
          post_users
          expect(response.body).to include("Login has already been taken")
        end
      end
    end
  end
end
