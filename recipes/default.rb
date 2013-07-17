cfn = CfnMetadataLoader.new(node['cfn_metadata']['stack_name'],
                            node['cfn_metadata']['region'],
                            node['cfn_metadata']['resource_name'],
                            node['cfn_metadata']['access_key'],
                            node['cfn_metadata']['secret_key'],
                            node['cfn_metadata']['cfn_path'])

cfn_data = cfn.sanitized_metadata

node.set['cfn_metadata']['data'] = cfn_data
