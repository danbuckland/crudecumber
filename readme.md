# Crudecumber

Manually run through your Gherkin scenarios using Cucumber.

To run, do the following:

1. Downlaod the source code
2. **CD** to the **crudecumber** directory in terminal
If you have RVM installed, type **y** when prompted to automatically create a ruby environment and install required gems
3. Type **cucumber** in the terminal to run
4. For each step, press **Enter** to pass or type anything else to fail
 * You will be prompted to add notes to failing steps which will then appear
5. After running all scenarios, type **open crudecumber_results.html** to see the generated report.
6. Add your own features to the features directory with the **@****manual** tag.

This project is work in progress and currently does the job but is not as elegant as it could be. If you'd like to contribute, branch and generate a pull request. Do not self approve!
