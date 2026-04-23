# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

Crudecumber is a Ruby gem that wraps Cucumber to enable **manual** BDD test execution. Instead of running automated step definitions, it intercepts every Gherkin step and prompts the tester to mark it pass (p/Enter), fail (f/x — prompts for a note), or skip (s). It generates an HTML report at the end.

## Commands

All commands run from `ruby-gem/`:

```bash
gem build crudecumber.gemspec    # Build the gem
gem install crudecumber          # Install locally
crudecumber                      # Run all feature scenarios
crudecumber -t @tag              # Run scenarios with a specific tag
crudecumber --v                  # Verbose/debug mode
```

To run a single feature's scenarios, use its tag (defined at the top of each `.feature` file):

```bash
crudecumber -t @basics
crudecumber -t @tables
crudecumber -t @docstrings
```

## Architecture

The gem works by injecting itself into Cucumber as both a step definition library and a custom formatter.

**Execution flow:**

1. `bin/crudecumber` → requires `lib/crudecumber.rb`
2. `lib/crudecumber.rb` builds a `cucumber` shell command that passes in:
   - `lib/crudecumber/crudecumber_steps.rb` as a step definitions file
   - `lib/crudecumber/support/` as support files
   - `CrudecumberFormatter` and `CrudecumberReport` as formatters
3. `crudecumber_steps.rb` defines a **single catch-all step** (`Then(/^.*$/)`) that captures keyboard input for every step via `PassFail`.
4. `support/pass_fail.rb` handles raw terminal I/O using `stty` to read single keypresses without blocking or echoing.
5. `support/crudecumber_formatter.rb` provides two formatters:
   - `Formatter` (extends `Cucumber::Formatter::Pretty`): prints each step to terminal *before* the step executes, then suppresses Cucumber's own exception output.
   - `Report` (extends `Cucumber::Formatter::Html`): generates `crudecumber_results.html`, also with exception output suppressed.

**Key constraint:** The gem targets Cucumber ~> 1.3 and is incompatible with Cucumber 2.0+. The formatter classes inherit from Cucumber 1.3 internal classes.

## Feature Tests

The `features/` directory contains Cucumber scenarios that test Crudecumber's own behavior (meta-testing). They are tagged and cover: basic scenarios (`@basics`), backgrounds (`@backgrounds`), data tables (`@tables`), doc strings (`@docstrings`), and scenario outlines (`@examples`/`@bugs`).
