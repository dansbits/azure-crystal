require "spec"
require "webmock"
require "../src/azure-sdk"

Spec.before_each &->WebMock.reset
