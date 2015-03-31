# Crudecumber

Manually run through your Gherkin scenarios using Cucumber.

To run, do the following:

1. Downlaod the source code
2. **CD** to the **crudecumber** directory in terminal
3. If you have RVM installed, type **y** when prompted to automatically create a ruby environment and install required gems
3. Type **cucumber** in the terminal to run
4. For each step, press **Enter** to pass or type anything else to fail
    * You will be prompted to add notes to failing steps which will then appear

5. After running all scenarios, type **open crudecumber_results.html** to see the generated report.
6. Add your own features to the features directory with the **@****manual** tag.

## Adding Crudecumber to an existing automation suite

To add manual Crudecumber scenarios to an existing automation suite do the following:

1. Make sure any scenarios that you want to run manually are tagged with **@****manual**
2. Add **crudecumber\_steps.rb** to your step\_definitions folder
3. Create a manual\_report.rb file and add it to the **support** folder

```ruby
require 'launchy'
at_exit do
puts "Report generated. Enter \'open crudecumber_results.html\' in terminal to view."
directory = Dir.pwd
Launchy.open("file:///" + directory + "/crudecumber_results.html")
end
```

4. Modify or create a cucumber.yml file to have a **manual** profile which will require the crudecumber\_steps.rb and manual\_report.rb files

    Example manual profile:
    
```
    manual: --tags @manual -r features/step_definitions/crudecumber_steps.rb -r features/support/manual_report.rb -f 'Slowhandcuke::Formatter' -f html -o crudecumber_results.html
```

5. Modify cucumber.yml file to exclude the previous two files in the automation profile by using the **-e** tag
6. Add any missing gems to your Gemfile


This project is work in progress and currently does the job but is not as elegant as it could be. If you'd like to contribute, branch and generate a pull request. Do not self approve!
