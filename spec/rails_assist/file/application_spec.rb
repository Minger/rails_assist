require 'spec_helper'

CLASS = RailsAssist::File::Special

class AppDir
  include CLASS
end

describe RailsAssist::File::Application do
  # use_helper :directories

  before do
    RailsAssist::Directory.rails_root = fixtures_dir
  end

  before :each do
    file_name = CLASS.application_filepath
    FileUtils.cp file_name, file_name + '.bak'
  end

  after :each do
    file_name = CLASS.application_filepath
    FileUtils.mv file_name + '.bak', file_name
  end

  describe '#insert_application_config' do
    it "should return the #{name} file path" do
      CLASS.insert_application_config 'hello = 2'
      content = CLASS.read_application_file
      content.should match /Rails::Application\n\s+config\.hello = 2/
    end
  end
end