bazel Cookbook
=======================
Installs/Configures [Bazel](http://bazel.io)

[![Build Status](https://travis-ci.org/gengo/cookbook-bazel.svg?branch=master)](https://travis-ci.org/gengo/cookbook-bazel)


Requirements
------------
#### chef
Chef 12+

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
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['bazel']['version']</tt></td>
    <td>String</td>
    <td>Bazel version to install</td>
    <td><tt>0.2.3</tt></td>
  </tr>
  <tr>
    <td><tt>['bazel']['prefix']</tt></td>
    <td>String</td>
    <td>installation prefix</td>
    <td><tt>/usr/local</tt></td>
  </tr>
</table>

Usage
-----
#### bazel::default
Just include `bazel` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[bazel]"
  ]
}
```

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
