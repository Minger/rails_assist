require 'spec_helper'

CLASS = RailsAssist::File::Special

class AppDir
  include CLASS
end

describe RailsAssist::File::Environment do
  # use_helper :directories

  before do
    RailsAssist::Directory.rails_root = fixtures_dir
  end

  before :each do
    file_name = CLASS.environment_filepath
    FileUtils.cp file_name, file_name + '.bak'
  end

  after :each do
    file_name = CLASS.environment_filepath
    FileUtils.mv file_name + '.bak', file_name
  end

  describe '#insert_before_application_init' do
    it "should add code or content BEFORE the application is initialized" do
      CLASS.insert_before_application_init 'config.hello = 2'
      content = CLASS.read_environment_file
      content.should match /config\.hello = 2\n(.*)::Application.initialize!/
    end
  end
  
  describe '#insert_after_application_init' do
    it "should add code or content AFTER the application is initialized" do
      CLASS.insert_after_application_init 'config.hello = 2'
      content = CLASS.read_environment_file
      content.should match /::Application.initialize!\n(.*)config\.hello = 2/
    end
  end
  
  describe '#insert_application_init' do
    it "should add code or content AFTER the application is initialized" do
      CLASS.insert_application_init :after, 'config.hello = 2'
      content = CLASS.read_environment_file
      content.should match /::Application.initialize!\n(.*)config\.hello = 2/
    end
  end
end