require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    subject { post "/users", params: params }

    context "with a valid params" do
      let(:params) do
          {
            user: {
              login: "johndoe",
              name: "John Doe",
              password: "password123",
              date_of_birth: Date.new(1994, 10, 19)
            }
          }
      end

      it "creates a User in database" do
        expect { subject }.to change(User, :count).by(1)
      end

      it "responds status created" do
        subject
        expect(response).to have_http_status(:created)
      end
    end

    context "with login missing" do
      let(:params) do
        {
          user: {
            password: "password123",
            name: "John Doe",
            date_of_birth: Date.new(1994, 10, 19)
          }
        }
      end

      it "does not create a User in database" do
        expect { subject }.not_to change(User, :count)
      end

      it "responds status :unprocessable_entity" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with password missing" do
      let(:params) do
        {
          user: {
            login: "johndoe",
            name: "John Doe",
            date_of_birth: Date.new(1994, 10, 19)
          }
        }
      end

      it "does not create a User in database" do
        expect { subject }.not_to change(User, :count)
      end

      it "responds status :unprocessable_entity" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with name missing" do
      let(:params) do
        {
          user: {
            login: "johndoe",
            password: "password123",
            date_of_birth: Date.new(1994, 10, 19)
          }
        }
      end

      it "does not create a User in database" do
        expect { subject }.not_to change(User, :count)
      end

      it "responds status :unprocessable_entity" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "with date_of_birth missing" do
      let(:params) do
        {
          user: {
            login: "johndoe",
            password: "password123",
            name: "John Doe"
          }
        }
      end

      it "does not create a User in database" do
        expect { subject }.not_to change(User, :count)
      end

      it "responds status :unprocessable_entity" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when login already exists" do
      before do
        User.create!(
          login: "johndoe",
          name: "John",
          password: "secret",
          date_of_birth: Date.new(1934, 11, 12)
        )
      end

      let(:params) do
        {
          user: {
            login: "johndoe",
            name: "John Doe",
            password: "password123",
            date_of_birth: Date.new(1994, 10, 19)
          }
        }
      end

      it "responds :unprocessable_entity" do
        subject
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "renders template :new" do
        subject
        expect(response.body).to include("Login has already been taken")
      end
    end
  end
end
