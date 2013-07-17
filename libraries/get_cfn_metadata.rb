class Chef::Recipe::CfnMetadataLoader

  IGNORED_METADATA_KEYS = [ 'AWS::CloudFormation::Init',
                            'AWS::CloudFormation::Authentication' ]
  def initialize(stack_name, region, resource_name, access_key, secret_key, cfn_path="/opt/aws/bin/cfn-get-metadata")
    @stack_name = stack_name
    @region = region
    @resource_name = resource_name
    @access_key = access_key
    @secret_key = secret_key
    @cfn_path = cfn_path

  end

  def sanitized_metadata
    data = raw_cfn_metadata.reject { |k,v| IGNORED_METADATA_KEYS.include? k }
    data = data.to_hash.select { |k, v| k =~ /app_/}
    data = organize_cfn_metadata data
    data
  end

  private
  def raw_cfn_metadata
    output = `#{cfn_metadata_command}`
    raise RuntimeError 'Unable to get cloud formation metadata' unless $?.success?
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
  
  def organize_cfn_metadata(app_vars)
    app_vars.each_pair do |k,v|
      app_vars[k] = v.join(',') if v.kind_of? Enumerable
    end 

    app_vars.keys.each do |key|
     app_vars[key.gsub('app_', '')] = app_vars[key]
       app_vars.delete key
    end
    app_vars
  end

end
