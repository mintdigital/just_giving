require 'helper'

class TestFundraising < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end

  context 'using basic auth' do
    setup do
      JustGiving::Configuration.username = 'test'
      JustGiving::Configuration.password = 'secret'
    end

    should 'get pages' do
      stub_get('/v1/fundraising/pages', 'test:secret').with(:headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('fundraising_pages_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      pages = JustGiving::Fundraising.new.pages
    end

    should 'get donations' do
      stub_get('/v1/fundraising/pages/test/donations?pageNum=1&page_size=50', 'test:secret').with(
        :headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('fundraising_donations_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      pages = JustGiving::Fundraising.new('test').donations
    end

    should 'set pagination options for donations' do
      stub_get('/v1/fundraising/pages/test/donations?pageNum=2&page_size=10', 'test:secret').with(
        :headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('fundraising_donations_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      pages = JustGiving::Fundraising.new('test').donations(2, 10)
    end

    should 'create page' do
      stub_put('/v1/fundraising/pages', 'test:secret').with(:headers => {'Accept'=>'application/json'}).to_return(
      :body => fixture('fundraising_pages_success.json'),
      :headers => {:content_type =>  'application/json; charset=utf-8'}, :status => 201)
      page = JustGiving::Fundraising.new.create({})
    end

    should 'update story' do
      stub_post('/v1/fundraising/pages/test', 'test:secret').with(:headers => {'Accept'=>'application/json',
      'Content-Type'=>'application/json'}, :body => '{"storySupplement":"new story"}').to_return(
      :body => fixture('fundraising_update_story_success.json'),
      :headers => {:content_type =>  'application/json; charset=utf-8'}, :status => 200)
      page = JustGiving::Fundraising.new('test').update_story('new story')
    end
  end

  context 'with no basic auth' do
    should 'check if short name is registered' do
      stub_head('/v1/fundraising/pages/test').with({
        :headers => {'Accept'=>'application/json'}
      }).to_return({
        :status => 200, 
        :headers => {
          :content_type =>  'application/json; charset=utf-8'
        },
        :body => "{}"
      })
      assert JustGiving::Fundraising.new('test').short_name_registered?
    end

    should 'check if short name is registered when not found' do
      stub_head('/v1/fundraising/pages/test').with(:headers => {'Accept'=>'application/json'}).to_return(
        :status => 404, :headers => {:content_type =>  'application/json; charset=utf-8'})
      assert !JustGiving::Fundraising.new('test').short_name_registered?
    end

    should 'get fundraising page' do
      stub_get('/v1/fundraising/pages/test').with(:headers => {'Accept'=>'application/json'}).to_return(
      :body => fixture('fundraising_get_page_success.json'), :status => 200,
      :headers => {:content_type =>  'application/json; charset=utf-8'})
      page = JustGiving::Fundraising.new('test').page
      assert_equal "00A246", page["branding"]["buttonColour"]
      assert_equal "261017", page["charity"]["registrationNumber"]
    end
  end
end
