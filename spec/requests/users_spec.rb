require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /register" do
    subject(:get_register) { get register_path }

    context "when user is not logged in" do
      it "returns HTTP status :ok" do
        get_register
        expect(response).to have_http_status(:ok)
      end

      it "renders template :new" do
        get_register
        expect(response).to render_template(:new)
      end
    end

    context "when user is logged in" do
      before do
        user = create(:user, login: "johndoe", password: "password123")
        post login_path, params: { session: { login: "johndoe", password: "password123" } }
      end

      it "redirects to root page" do
        get_register
        expect(response).to redirect_to(root_path)
      end
    end
  end

  describe "POST /register" do
    subject(:post_register) { post register_path, params: params }

    shared_examples "invalid user creation" do
      it "does not create a User in database" do
        expect { post_register }.not_to change(User, :count)
      end

      it "responds with status unprocessable_entity" do
        post_register
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with valid params" do
      let(:params) { { user: attributes_for(:user) } }

      it "creates a User in database" do
        expect { post_register }.to change(User, :count).by(1)
      end

      it "redirects to root_path" do
        post_register
        expect(response).to redirect_to(root_path)
      end

      it "does not persist :password" do
        post_register
        expect(User.last.password).to be_nil
      end

      it "digests the password" do
        post_register
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
          post_register
          expect(response.body).to include("Login has already been taken")
        end
      end
    end
  end
end
