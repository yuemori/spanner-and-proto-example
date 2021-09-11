ActionDispatch::IntegrationTest.register_encoder(
  :protobuf,
  param_encoder: -> params { params.to_proto },
  response_parser: -> body { body }
)
