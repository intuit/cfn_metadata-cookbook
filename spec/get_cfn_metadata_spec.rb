require File.expand_path("../", __FILE__) + '/spec_helper'
require 'json'

describe CfnMetadataLoader do
  before do
    allow_message_expectations_on_nil
    stack_name    = 'my_stack_name'
    access_key    = 'my_access_key'
    cfn_path      = '/opt/aws/bin/cfn-get-metadata'
    region        = 'my_region'
    resource_name = 'my_resource_name'
    secret_key    = 'my_secret_key'

    @cfn = CfnMetadataLoader.new stack_name,
                                 region,
                                 resource_name,
                                 access_key,
                                 secret_key,
                                 cfn_path 
    @cmd = "#{cfn_path} "
    @cmd << "-s #{stack_name} "
    @cmd << "-r #{resource_name} "
    @cmd << "--region #{region} "
    @cmd << "--access-key #{access_key} "
    @cmd << "--secret-key #{secret_key}"

  end
  it "should return the metadata" do
    cmd_return = { 'AWS::CloudFormation::Init'           => 'test',
                   'AWS::CloudFormation::Authentication' => 'test', 
                   'stack_name'                          => 'my_stack_name' }.to_json
    @cfn.should_receive(:`).with(@cmd).and_return cmd_return
    $?.stub :success? => true
    @cfn.sanitized_metadata.should == ({ 'stack_name' => 'my_stack_name' })
  end

  it "should raise an error if unable to get metadata" do
    @cfn.should_receive(:`).with(@cmd)
    $?.stub :success? => false
    expect { @cfn.sanitized_metadata }.to raise_error
  end
end
