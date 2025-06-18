require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    subject(:get_login) { get login_path }

    it "returns HTTP status :ok" do
      get_login
      expect(response).to have_http_status(:ok)
    end

    it "renders template :new" do
      get_login
      expect(response).to render_template(:new)
    end
  end

  describe "POST /login" do
    subject(:post_login) { post login_path, params: params }

    before do
      create(:user, login: "johndoe", password: "password123")
    end

    context "with valid credentials" do
      let(:params) { { login: "johndoe", password: "password123" } }

      it "returns HTTP status :ok" do
        post_login
        expect(response).to have_http_status(:ok)
      end

      it "sets user_id in the session" do
        post_login
        user = User.find_by(login: "johndoe")
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "with invalid params" do
      let(:params) { { login: "johndoe", password: "invalid_password" } }

      it "returns HTTP status :unauthorized" do
        post_login
        expect(response).to have_http_status(:unauthorized)
      end

      it "does not set the user_id in session" do
        post_login
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    subject(:delete_logout) { delete logout_path }

    before do
      create(:user, login: "johndoe", password: "password123")
      post login_path, params: { login: "johndoe", password: "password123" }
    end

    it "returns HTTP status :found" do
      delete_logout
      expect(response).to have_http_status(:found)
    end

    it "redirects to login page" do
      delete_logout
      expect(response).to redirect_to(login_path)
    end

    it "clears the user_id from the session" do
      delete_logout
      expect(session[:user_id]).to be_nil
    end
  end
end
