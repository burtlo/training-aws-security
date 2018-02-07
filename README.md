# Chef Training AWS InSpec Profile

Exploring defining a profile and testing out AWS resources using inspec-aws.

## Getting Started.

Maybe none of this will be required in the future. At the time of me writing
to use the `inspec-aws` resources you need to:

* Install InSpec 1.51.0
* Install the aws-sdk gem into that installation

```
$ sudo /opt/inspec/embedded/bin/gem install aws-sdk
```

* Clone my fork of `inspec-aws`
* Define all the AWS ENV as described in the `inspec-aws` README
* Create the exact situation to make this pass
