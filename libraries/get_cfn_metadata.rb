class CfnMetadataLoader

  def initialize(stack_name, region, resource_name, access_key, secret_key, cfn_path)
    @stack_name = stack_name
    @region = region
    @resource_name = resource_name
    @access_key = access_key
    @secret_key = secret_key
    @cfn_path = cfn_path
  end

  def sanitized_metadata
    raw_cfn_metadata.reject { |k,v| ignored_metadata_keys.include? k }
  end

  private

  def ignored_metadata_keys
    [ 'AWS::CloudFormation::Init','AWS::CloudFormation::Authentication' ]
  end

  def raw_cfn_metadata
    output = `#{cfn_metadata_command}`
    raise 'Unable to get cloud formation metadata' unless $?.success?
    JSON.parse output
  end
 
  def cfn_metadata_command
    cmd = "#{@cfn_path} "
    cmd << "-s #{@stack_name} "
    cmd << "-r #{@resource_name} "
    cmd << "--region #{@region} "
    cmd << "--access-key #{@access_key} "
    cmd << "--secret-key #{@secret_key}"
  end

end
