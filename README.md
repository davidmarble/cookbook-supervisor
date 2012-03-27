# Description

Chef cookbook for supervisor, a python-based process manager.

**NOTE:** Make sure to rename this to `supervisor` if you clone it or 
incorporate it as a git submodule in your cookbooks.

## Recipes

### supervisor

Install and run supervisor. Configuration for processes you want to manage 
should be placed in separate files under 
`templates/<default>/etc/supervisor/{name}.conf.erb`. Because these are 
templates, you can add template variables depending on your setup.

Template examples included:

* etherpad-lite
* pgbouncer
* rabbitmq
* redis

Add an entry to your chef configuration for all configuration files 
you want to include and manage with supervisor:

    "supervisor": {
        "includes": ["etherpad-lite", "redis"]
    }


# License and Author

Author:: David Marble (<davidmarble@gmail.com>)

Copyright:: 2012, David Marble

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
