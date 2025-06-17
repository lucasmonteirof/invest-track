require "rails_helper"

RSpec.describe "Sessions", type: :request do
  describe "GET /login" do
    before { get login_path }

    it "returns HTTP status :ok" do
      expect(response).to have_http_status(:ok)
    end

    it "renders template :new" do
      expect(response).to render_template(:new)
    end
  end

  describe "POST /login" do
    let!(:user) { create(:user, login: "johndoe", password: "password123") }

    context "with valid credentials" do
      subject { post login_path, params: { login: "johndoe", password: "password123" } }

      before { subject }

      it "returns HTTP status :ok" do
        expect(response).to have_http_status(:ok)
      end

      it "sets user_id in the session" do
        expect(session[:user_id]).to eq(user.id)
      end
    end

    context "with invalid credentials" do
      subject { post login_path, params: { login: "johndoe", password: "wrong_password" } }

      before { subject }

      it "returns HTTP status :unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end

      it "does not set the user_id in session" do
        expect(session[:user_id]).to be_nil
      end
    end
  end

  describe "DELETE /logout" do
    subject { delete logout_path }

    before do
      create(:user, login: "johndoe", password: "password123")
      post login_path, params: { login: "johndoe", password: "password123" }
      subject
    end

    it "returns HTTP status :found" do
      expect(response).to have_http_status(:found)
    end

    it "redirects to login page" do
      expect(response).to redirect_to(login_path)
    end

    it "clears the user_id from the session" do
      expect(session[:user_id]).to be_nil
    end
  end
end
