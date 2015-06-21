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
After installing **Crudecumber**, simply type `crudecumber` in a terminal from within a directory that contains a **features** folder with at least one ***.feature*** file.

Your features and scenarios are run as they would be with Cucumber, but stop at each step to await one of the following keyboard inputs:
* **P** or **Return** to **pass** the step.
* **F** or **X** to **fail** the step and then type in the reason.
* **S** to **Skip** the step.

You can append any of the usual Cucumber arguments to, for example, run a subset of your tests e.g.:

`crudecumber -t @manual` to run only those scenarios tagged with **@manual**


## Known issues and limitations

Crudecumber is in its infancy and will be capable of more in time. In the current release there are the following known issues:
* **Crudecumber is not compatible with Cucumber 2.0 or above.** Even if you're not using Cucumber 2.0 but you have it installed, you'll have a problem with steps not being rendered until after they are passed, failed or skipped. The best way to avoid this is to use [rvm](https://rvm.io/) and use a separate gemset for your Cucumber 2.0 stuff.
* Crudecumber automatically opens an HTML report at the end of a test run and requires **launchy** to open it. If you are using bundler, you may see the error ***cannot load such file -- launchy (LoadError)***. This can be remedied by updating your Gemfile and doing a `bundle install`.
* This tool has been developed and tested on Mac OSX and Linux. Windows users may have trouble getting it to run.

If you'd like to contribute to this project and perhaps fix any of the above, please fork the project, make and test your change and then generate a pull request!


## Copyright

Copyright (c) 2015 Dan Buckland and Contributors. See LICENSE for details.
