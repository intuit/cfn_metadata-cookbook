cfn = CfnMetadataLoader.new node['cfn_metadata']['stack_name'],
                            node['cfn_metadata']['region'],
                            node['cfn_metadata']['resource_name'],
                            node['cfn_metadata']['access_key'],
                            node['cfn_metadata']['secret_key'],
                            node['cfn_metadata']['cfn_get_metadata_bin']

node.set['cfn_metadata']['data'] = cfn.sanitized_metadata
