# frozen_string_literal: true

load 'vendor/bundle/bundler/setup.rb'
require 'ougai'
require 'base64'

# Every invocation gets passes an event & context.
# :event has the actual message in it.
# :context has its charms too!
#   https://docs.aws.amazon.com/lambda/latest/dg/ruby-context.html
def hello(event:, context:)
  logger = Ougai::Logger.new(STDOUT)
  logger.info("Lambda invoked", original_event: event)

  # Let's see what's in the message
  event['Records'].each do |record|
    encoded_message = record['kinesis']['data']
    decoded_message = Base64.decode64(encoded_message)
    logger.info("What was actually published?", message: decoded_message)
  end
end
