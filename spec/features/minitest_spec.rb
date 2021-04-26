require 'rails_helper'

feature 'proxy_test', js: true do

  it 'shows an external site' do
    visit 'https://www.heise.de'
  end
end
