require 'helper'

class TestSearch < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end

  context 'searching' do
    should 'search with default options' do
      stub_get('/v1/charity/search?q=test&page=1&pageSize=10').to_return(
        :body => fixture('search_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      search = JustGiving::Search.new.search_charities('test')
      assert_equal "311", search['charitySearchResults'].first['charityId']
    end

    should 'use supplied page/per_page' do
      stub_get('/v1/charity/search?q=test&page=2&pageSize=1').to_return(
        :body => fixture('search_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      search = JustGiving::Search.new.search_charities('test', 2, 1)
      assert_equal "311", search['charitySearchResults'].first['charityId']
    end

    should 'not search with invalid options' do
      stub_get('/v1/charity/search?q=&page=2&pageSize=1').to_raise(JustGiving::NotFound)
      assert_raise JustGiving::NotFound do
        search = JustGiving::Search.new.search_charities('', 2, 1)
      end
    end
  end
end