# Ovaltine

Ovaltine is a tool to help find the encoding of a message. Named after the company behind the decoder rings immortalized by the [Christmas Story](http://en.wikipedia.org/wiki/Secret_decoder_ring), Ovaltine tries every combinator of every encoding it knows about to see if the output is anything meaningful. There are a configurable set of checks that you can run across the decoded output to check whether it's meaninful. Currently it checks whether a certain percentage of the output matches the english dictionary. 

## Installation

Add this line to your application's Gemfile:

    gem 'ovaltine'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ovaltine

## Usage

```
$ ovaltine [-options ...] FILE 

  # Decoders
  -i    # Ignore all checks
  -n    # Maximum number of decoders to chain together
  
  # Validations
  --english-confidence=[default 0.15]     # Percentage of english words to pass
  ...
  ..
  .

```

## Contributing



