require 'spec_helper'

describe ArticlesController do
  let!(:article) { create :article }
  describe "GET #index" do
    before { get :index }
    it { should respond_with :success }
    it { should render_template :index }
    it { should assign_to(:articles).with [article] }
  end

  describe "GET #show" do
    before { get :show, id: article }
    it { should respond_with :success }
    it { should render_template :show }
    it { should assign_to(:article).with article }
  end
end
