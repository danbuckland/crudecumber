# Crudecumber

[![Gem Version](https://badge.fury.io/rb/crudecumber.svg)](http://badge.fury.io/rb/crudecumber)

Crudecumber lets you manually step through Gherkin scenarios in the terminal without writing any step definitions or running a test framework. It parses `.feature` files directly and prompts you to mark each step as passed, failed, or skipped, then generates an HTML report.

It was developed to promote [Behaviour Driven Development](https://en.wikipedia.org/wiki/Behavior-driven_development) within teams that write Gherkin scenarios before they have the time or expertise to automate them.


## Prerequisites

Ruby 3.2 or higher. Check with `ruby -v`.


## Installation

```bash
gem install crudecumber
```

No other dependencies are required.


## Usage

Run `crudecumber` from any directory that contains a `features/` folder:

```bash
crudecumber
```

Each step pauses and waits for one of the following keypresses:

| Key | Action |
|-----|--------|
| `P` or `Return` | Pass the step |
| `F` or `X` | Fail the step (you'll be prompted to describe the problem) |
| `S` | Skip the step |

### Tag filtering

Run only scenarios tagged with a specific tag:

```bash
crudecumber -t @manual
```

### Specific files or directories

Pass one or more paths instead of relying on the default `features/` directory:

```bash
crudecumber features/checkout.feature
crudecumber features/payments/ features/auth/
```

### Verbose output

```bash
crudecumber --v
```


## Output

After all scenarios have run, `crudecumber_results.html` is written to the current directory and its path is printed to the terminal.


## Notes

- Works against any `.feature` file regardless of what test framework (if any) the project uses — Crudecumber has no dependency on Cucumber or any other test tool.
- Supports all standard Gherkin constructs: Scenario, Scenario Outline (each example row runs as a separate scenario), Background, data tables, and doc strings.
- Developed and tested on macOS and Linux. Windows is not supported due to the use of `stty` for raw terminal input.


## Contributing

Fork the repository, make and test your change, then open a pull request.


## Copyright

Copyright (c) 2015–2026 Dan Buckland and Contributors. See LICENSE for details.
