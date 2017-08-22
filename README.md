# Crudecumber

[![Gem Version](https://badge.fury.io/rb/crudecumber.svg)](http://badge.fury.io/rb/crudecumber)

Crudecumber allows developers and testers to manually run through Cucumber scenarios written in Gherkin in the command line without the need for any step definitions.

Crudecumber was developed as a tool to promote the use of [Behaviour Driven Development](https://en.wikipedia.org/wiki/Behavior-driven_development) and [Cucumber](https://github.com/cucumber/cucumber "Cucumber GitHub Repository") within teams that might not have the time or expertise to turn their scenarios into automated tests.


## Installation
### Prerequisites
You must have Ruby 1.9.3 or higher running on your machine. Enter `ruby -v` in a terminal to see the version that is currently running.

### Installation
Install the **Crudecumber** Ruby gem by running `gem install crudecumber`. Additional dependencies, including Cucumber and its dependencies, will automatically be downloaded and installed at this time.

### Running
**Crudecumber** can be run in two different ways, the simplest is to just run **Crudecumber** directly in the terminal. The alternative is to have **Crudecumber** called and run by Cucumber using a profile in an existing test suite. Both methods are described below.

#### Running as Crudecumber
After installing **Crudecumber**, simply type `crudecumber` in a terminal from within a directory that contains a **features** folder with at least one ***.feature*** file.

Your features and scenarios are run as they would be with Cucumber, but stop at each step to await one of the following keyboard inputs:
* **P** or **Return** to **pass** the step.
* **F** or **X** to **fail** the step and then type in the reason.
* **S** to **Skip** the step.

You can append any of the usual Cucumber arguments to, for example, run a subset of your tests e.g.:

`crudecumber -t @manual` to run only those scenarios tagged with **@manual**

#### Running as a Cucumber Profile
Using a `cucumber.yml` file, it's possible to have **Crudecumber** run your scenarios for one or more [Cucumber profiles](https://github.com/cucumber/cucumber/wiki/cucumber.yml). This allows the user to use **Crudecumber** to run tests, or a subset of tests, manually by typing, for example, `cucumber -p manual`.

After installing **Crudecumber**, you'll need to require it in your automation suite. However, as soon as **Crudecumber** is loaded into your environment, it will be used to run every scenario.

To avoid **Crudecumber** being used on your already automated scenarios, it's recommended to conditionally `require 'crudecumber'` based on a specific tag. In the below example, we're using the tag **@manual**.

Add the following in the **Before** part of your `env.rb` file:
```ruby
# features/support/env.rb

Before do |scenario|  
  if scenario.source_tag_names.include? "@manual"
    require 'crudecumber'
  end
end
```

This will work now if you were to run `cucumber -t @manual`. However, to avoid scenarios tagged with **@manual** being run during automated test runs, it's recommended to exclude these scenarios from all other profiles.

Add a **manual** profile to run scenarios tagged **@manual** and exclude scenarios tagged **@manual** from other profiles in your project's `cucumber.yml` file:

```yaml
# config/cucumber.yml

default: -t ~@manual -f pretty -f html -o automated_test_report.html
manual: -t @manual

```
Then run your manual tests by typing `cucumber -p manual` in a terminal and using the keyboard inputs described in the previous section.

**Crudecumber** uses its own modified formatters to display scenarios in the terminal and output an html report without error messages. Including other formatters and outputs in your **manual** profile may break something.

#### Force Crudecumber from Cucumber
Depending on the structure of you Cucumber tests, you may encounter an issue with the above where Cucumber runs again after **Crudecumber** has finished. This tends to occur if you have a lot going on in your **support** directory or you're using a framework like [Calabash](https://github.com/calabash "Calabash GitHub account").

To fix, replace `require 'crudecumber'` with the following in the **Before** part of you `env.rb` file:
```ruby
# features/support/env.rb

Before do |scenario|  
  if scenario.source_tag_names.include? "@manual"
    exec('crudecumber -p manual')
  end
end
```
Using `exec` replaces the currently running process – in this case Cucumber – with the specified new process – in this case **Crudecumber**.

As before, use a **manual** profile to run scenarios tagged **@manual** and exclude scenarios tagged **@manual** from other profiles in your project's `cucumber.yml` file:

```yaml
# config/cucumber.yml

default: -t ~@manual -f pretty -f html -o automated_test_report.html
manual: -t @manual -f progress

```
Adding `-f progress` will prevent the first feature being printed before **Crudecumber** is called.

For this to work, you should ensure that you have **Crudecumber** in your Gemfile and installed through bundler.


## Known issues and limitations
Crudecumber should now be feature complete, i.e. it should be able to work with all standard Cucumber scenario types. If you spot a bug, please raise an issue against the project.

In the current release there are the following known issues:
* **Crudecumber is not compatible with Cucumber 2.0 or above.** Even if you're not using Cucumber 2.0 but you have it installed, you'll have a problem with steps not being rendered until after they are passed, failed or skipped. The best way to avoid this is to use [rvm](https://rvm.io/) and use a separate gemset for your Cucumber 2.0 stuff.
* This tool has been developed and tested on Mac OSX and Linux. Windows users may have trouble getting it to run.

If you'd like to contribute to this project and perhaps fix any of the above, please fork the project, make and test your change and then generate a pull request!


## Copyright

Copyright (c) 2015-2017 Dan Buckland and Contributors. See LICENSE for details.
