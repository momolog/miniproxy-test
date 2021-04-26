require 'rails_helper'

feature 'proxy_test', js: true do

  it 'shows an external site' do
    MiniProxy.allow_request(method: "GET", url: /heise.de/)
    visit 'https://www.heise.de'
  end
end
