require 'arrthorizer/rails'

class SomeController < ApplicationController
  to_prepare_context do |c|
    c.defaults do
      { some_param: params[:some_param] }
    end
  end

  before_filter :authorize

  def some_action
  end

  def other_action
  end
end
