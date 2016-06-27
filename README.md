bazel Cookbook
=======================
Installs/Configures [Bazel](http://bazel.io)

[![Build Status](https://travis-ci.org/gengo/cookbook-bazel.svg?branch=master)](https://travis-ci.org/gengo/cookbook-bazel)

Usage
-----
#### bazel::default Recipe
Just include `bazel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bazel]"
  ]
}
```

#### Custom Resources

```ruby
bazel_installation('bazel') do
  version '0.3.0'
  action :create
end
```

Requirements
------------
#### chef
Chef 12.5+

#### cookbooks
* build-essential
* java
* poise-python
* zip
* apt
* homebrew

Attributes
----------

#### bazel::default
| Key                                | Type    | Description              | Default      |
|------------------------------------|---------|--------------------------|--------------|
| `['bazel']['version']`             | String  | Bazel version to install | 0.3.0        |
| `['bazel']['prefix']`              | String  | installation prefix      | `/usr/local` |
| `['bazel']['installation_method']` | String  | how to install Bazel     | package      |

Valid values for `installation_method` are:

`script`
: Installs Bazel with an installer script
`package`
: Installs Bazel with a package management system in the package
`homebrew`
: More specifically than `package`, installs Bazel with homebrew
`apt`
: More specifically than `package`, installs Bazel with apt


Recipes
---------
#### bazel::bazel

Installs Bazel and its minimal dependencies

#### bazel::default

Installs other recommended tools in addition to `bazel::bazel`.


Resources
----------
#### bazel\_installation
Automatically selects a right installation method and installs Bazel.

##### Example

```ruby
bazel_installation('bazel') do
  version '0.3.0'
  action :create
end
```

##### Properties

* `version` - Bazel version to install


#### bazel\_installation\_package
Automatcially selects a right package management system and installs Bazel with it.

##### Example

```ruby
bazel_installation_package('bazel') do
  version '0.3.0'
  action :create
end
```

##### Properties

* `version` - Bazel version to install


#### bazel\_installation\_homebrew
Installs bazel with homebrew


#### bazel\_installation\_apt
Installs bazel with apt

#### bazel\_installation\_script
Installs bazel with an installer scirpt.


###### Example

```ruby
bazel_installation_script('bazel') do
  version '0.3.0'
  action :create
end
```

##### Properties

* `version` - Verion of Bazel to install
* `prefix` - installation prefix
* `installer_uri` - URI to the installer
* `installer_checksum` - SHA256 sum of the installer


Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write chefspec for the feature (if applicable)
4. Write your change
4. Write serverspec for the feature (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Copyright 2016 Gengo Inc.

BSD 3-Clause license
