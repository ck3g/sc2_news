require 'spec_helper'

describe TagsController do
  login_admin

  let!(:tag1) { create :tag }
  let!(:tag2) { create :tag }

  describe "GET #index" do
    context "when view tag cloud" do
      before { get :index }
      it { should_not assign_to(:tags) }
      it { should respond_with :success }
      it { should render_template :index }
    end

    context "when view tag cloud" do
      before { get :index, manage: 1 }
      it { should assign_to(:tags).with [tag1, tag2] }
    end
  end

  describe "GET #edit" do
    before { get :edit, id: tag1 }
    it { should render_template :edit }
    it { should respond_with :success }
    it { should assign_to(:tag).with tag1 }
  end

  describe "PUT #update" do
    context "when valid attributes" do
      def update_tag_name
        put :update, id: tag1, tag: attributes_for(:tag, name: "Updated tag")
      end

      before do
        update_tag_name unless example.metadata[:skip_before]
      end

      it { should assign_to(:tag).with tag1 }
      it { should redirect_to tags_path(manage: 1) }
      it { should set_the_flash[:notice].to I18n.t(:updated_successfully) }
      it "changes tag name", skip_before: true do
        expect {
          update_tag_name
          tag1.reload
        }.to change(tag1, :name).to "Updated tag"
      end
    end

    context "when invalid attributes" do
      def update_with_no_name
        put :update, id: tag1, tag: attributes_for(:tag, name: "")
      end

      before do
        update_with_no_name unless example.metadata[:skip_before]
      end
      it { should render_template :edit }
      it { should assign_to(:tag).with tag1 }
      it { should_not set_the_flash }
      it "dont change the name", skip_before: true do
        expect { update_with_no_name }.to_not change(tag1, :name)
      end
    end
  end

  describe "DELETE #destroy" do
    def delete_tag
      delete :destroy, id: tag1
    end

    before do
      delete_tag unless example.metadata[:skip_before]
    end

    it { should redirect_to tags_path(manage: 1) }
    it "deletes the tag", skip_before: true do
      expect { delete_tag }.to change(Tag, :count).by(-1)
    end
  end
end
