# cfn_metadata cookbook
Calls the AWS cfn-get-metadata command to retrieve the Cloud Formation metadata which is returned in native format but strips out the Authentication and Init section.

# Requirements
The Amazon package, aws-cfn-bootstrap, that provides the cfn-get-metadata binary must be installed.

# Usage
Add to runlist

# Attributes
* default

`node['cfn_metadata']['stack_name']`    - name of cloud formation stack to query

`node['cfn_metadata']['region']`        - region stack is located

`node['cfn_metadata']['resource_name']` - cloud formation resource to query 

`node['cfn_metadata']['access_key']`    - access key for authentication

`node['cfn_metadata']['secret_key']`   - secret key for authentication 

`node['cfn_metadata']['cfn_get_metadata_bin']`  - path to binary, default "/opt/aws/bin/cfn-get-metadata"

# Recipes
* default

# Author

Author:: Intuit, Inc. (<kevin_young@intuit.com>)
