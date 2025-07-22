require "rails_helper"

RSpec.describe "Root path", type: :request do
  subject(:get_root) { get root_path }

  context "when user is not logged in" do
    it "redirects to the login page" do
      get_root
      expect(response).to redirect_to(login_path)
    end
  end

  context "when user is logged in" do
    before do
      user = create(:user, login: "johndoe", password: "password123")
      post login_path, params: { login: "johndoe", password: "password123" }
    end

    it "returns HTTP status :ok" do
      get_root
      expect(response).to have_http_status(:ok)
    end
  end
end
