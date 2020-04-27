RSpec.shared_context 'with a cli session', :cli_command do
  include_context 'with a dealing platform'

  before do
    dealing_platform_model IGMarkets::CLI::Main

    allow(IGMarkets::CLI::Main).to receive(:begin_session).and_yield(dealing_platform)
  end
end
