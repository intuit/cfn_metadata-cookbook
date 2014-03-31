require File.expand_path("../", __FILE__) + '/spec_helper'
require 'json'

describe CfnMetadataLoader do
  before do
    @stack_name    = 'my_stack_name'
    @cfn_path      = '/opt/aws/bin/cfn-get-metadata'
    @region        = 'my_region'
    @resource_name = 'my_resource_name'
    @process       = double 'process'

    @cmd = "#{@cfn_path} "
    @cmd << "-s #{@stack_name} "
    @cmd << "-r #{@resource_name} "
    @cmd << "--region #{@region} "
  end

  context "not using iam_profile" do
    before do
      @cfn = CfnMetadataLoader.new @stack_name,
                                   @region,
                                   @resource_name,
                                   "my_access_key",
                                   "my_secret_key",
                                   @cfn_path
      @cmd << "--access-key my_access_key "
      @cmd << "--secret-key my_secret_key"
    end

    it "should return the metadata" do
      cmd_return = { 'AWS::CloudFormation::Init'           => 'test',
                     'AWS::CloudFormation::Authentication' => 'test',
                     'stack_name'                          => 'my_stack_name' }.to_json
      @process.stub(:success?).and_return(true)
      @cfn.process_status = @process
      @cfn.should_receive(:`).with(@cmd).and_return cmd_return
      @cfn.sanitized_metadata.should == ({ 'stack_name' => 'my_stack_name' })
    end

    it "should raise an error if unable to get metadata" do
      @process.stub(:success?).and_return(false)
      @cfn.process_status = @process
      @cfn.should_receive(:`).with(@cmd)
      expect { @cfn.sanitized_metadata }.to raise_error
    end
  end

  context "using iam_profile" do
    before do
      @cfn = CfnMetadataLoader.new @stack_name,
                                   @region,
                                   @resource_name,
                                   "",
                                   "",
                                   @cfn_path
      @cfn.use_iam_profile = true
    end

    it "should return the metadata" do
      cmd_return = { 'AWS::CloudFormation::Init'           => 'test',
                     'AWS::CloudFormation::Authentication' => 'test',
                     'stack_name'                          => 'my_stack_name' }.to_json
      @process.stub(:success?).and_return(true)
      @cfn.process_status = @process
      @cfn.should_receive(:`).with(@cmd).and_return cmd_return
      @cfn.sanitized_metadata.should == ({ 'stack_name' => 'my_stack_name' })
    end

    it "should raise an error if unable to get metadata" do
      @process.stub(:success?).and_return(false)
      @cfn.process_status = @process
      @cfn.should_receive(:`).with(@cmd)
      expect { @cfn.sanitized_metadata }.to raise_error
    end
  end
end
