[![Code Climate](https://codeclimate.com/github/BUS-OGD/arrthorizer.png)](https://codeclimate.com/github/BUS-OGD/arrthorizer)
[![Build Status](https://travis-ci.org/BUS-OGD/arrthorizer.png)](https://travis-ci.org/BUS-OGD/arrthorizer)
[![Dependency Status](https://gemnasium.com/BUS-OGD/arrthorizer.png)](https://gemnasium.com/BUS-OGD/arrthorizer)
[![Gem Version](http://badge.fury.io/rb/arrthorizer.png)](http://badge.fury.io/rb/arrthorizer)

# Arrthorizer

Dynamic and static access control for your Rails (3+) application. Arrthorizer revolves around the concept of static roles (some kind of 'groups' the user can be a member of) and dynamic roles (detecting the relation the user has to the current context, like 'the writer of this blog post').

Arrthorizer is flexible and allows you to inject much of your own application logic into your authorization subsystem. It allows (that is, *requires*) you to determine which elements of a context are relevant for authorization and accepts your logic for determining whether a given user is part of a certain group.

Arrthorizer is [designed for ease of use and configurability](https://github.com/BUS-OGD/arrthorizer/wiki/Desired-and-required-features). Its Rails version (currently the *only* version) comes bundled with some useful generators and most of the configuration is done using a DSL in your controllers, along with a plain old YAML file.

## Installation

Add this line to your application's Gemfile:

    gem 'arrthorizer'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install arrthorizer
    
### Rails

After the above installation, run:

    $ bin/rails g arrthorizer:install

## Usage

After using the `arrthorizer:install` generator, your `git diff` will tell you everything you need to know. *Read the comments* to understand what you need to do to make it work.

When new ContextRoles are required later on, [Arrthorizer provides a generator for that](https://github.com/BUS-OGD/arrthorizer/wiki/HOWTO:-Write-a-ContextRole), too:

    $ bin/rails g arrthorizer:context_role {namespace_if_you_need_it/role_name}
    
This will generate a file containing the scaffold for the ContextRole and a couple of test cases for your test framework.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
