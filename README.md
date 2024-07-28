# Pkl

This is a Ruby implementation of the [Language Binding Specification](https://pkl-lang.org/main/current/bindings-specification/index.html) for Pkl. As recommended, it spins up a child process using the CLI and uses stdin/stdout over MessagePack to communicate.

Currently, my testing has not encountered cases where the following messages were received, so they remain unimplemented:
- ReadResource{Request|Response}
- ReadModule{Request|Response}
- ListResources{Request|Response}
- ListModules{Request|Response}

## Installation

Too lazy to get my rubygems.org stuff set up again right now.

Make sure that you've [installed Pkl](https://pkl-lang.org/main/current/pkl-cli/index.html#installation) and can run `pkl server`.

## Usage

The Pkl server is started up on-demand, and remains open for the duration of the process. It's a child process and should close along with the parent Ruby process, but you can run `Pkl::Server.close!` if you want.

```ruby
  # Create a new evaluator
  eva = Pkl::Evaluator.new(options = {})

  # Run it against a moduleUri
  result = eva.evaluate(moduleUri: "file:///path/to/your/file.pkl")

  # Close the evaluator
  eva.close!

  # One fell swoop:
  Pkl::Evaluator.new(options = {}) do
    evaluate(moduleUri: "file:///path/to/your/file.pkl")
  end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pkl-ruby.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
