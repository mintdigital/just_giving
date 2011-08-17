require 'helper'

class TestEvent < Test::Unit::TestCase
  def setup
    JustGiving::Configuration.application_id = '2345'
  end
  context 'with an event' do
    setup do
      @event = JustGiving::Event.new(1)
    end
    
    should 'get details' do
      stub_get('/v1/event/1').with(:headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('event_get_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      details = @event.details
      assert_equal 12356, details["id"]
      assert_equal "Playing Mario for charity", details["description"]
    end
    
    should 'get pages' do
      stub_get('/v1/event/1/pages').with(:headers => {'Accept'=>'application/json'}).to_return(
        :body => fixture('event_pages_success.json'),
        :headers => {:content_type =>  'application/json; charset=utf-8'})
      pages = @event.pages
      assert_equal 1234, pages["eventId"]
      assert_equal 1457423, pages["fundraisingPages"].first["pageId"]
    end
  end
end