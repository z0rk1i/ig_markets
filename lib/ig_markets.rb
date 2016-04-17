require 'base64'
require 'date'
require 'rest-client'
require 'thor'

require 'ig_markets/boolean'
require 'ig_markets/model'
require 'ig_markets/model/typecasters'
require 'ig_markets/regex'

require 'ig_markets/account'
require 'ig_markets/account_activity'
require 'ig_markets/account_transaction'
require 'ig_markets/api_versions'
require 'ig_markets/application'
require 'ig_markets/cli/orders_command'
require 'ig_markets/cli/positions_command'
require 'ig_markets/cli/sprints_command'
require 'ig_markets/cli/watchlists_command'
require 'ig_markets/cli/main'
require 'ig_markets/cli/account_command'
require 'ig_markets/cli/activities_command'
require 'ig_markets/cli/confirmation_command'
require 'ig_markets/cli/output'
require 'ig_markets/cli/search_command'
require 'ig_markets/cli/sentiment_command'
require 'ig_markets/cli/transactions_command'
require 'ig_markets/client_sentiment'
require 'ig_markets/deal_confirmation'
require 'ig_markets/dealing_platform'
require 'ig_markets/dealing_platform/account_methods'
require 'ig_markets/dealing_platform/client_sentiment_methods'
require 'ig_markets/dealing_platform/market_methods'
require 'ig_markets/dealing_platform/position_methods'
require 'ig_markets/dealing_platform/sprint_market_position_methods'
require 'ig_markets/dealing_platform/watchlist_methods'
require 'ig_markets/dealing_platform/working_order_methods'
require 'ig_markets/format'
require 'ig_markets/instrument'
require 'ig_markets/historical_price_result'
require 'ig_markets/market'
require 'ig_markets/market_overview'
require 'ig_markets/market_hierarchy_result'
require 'ig_markets/password_encryptor'
require 'ig_markets/payload_formatter'
require 'ig_markets/position'
require 'ig_markets/request_failed_error'
require 'ig_markets/response_parser'
require 'ig_markets/session'
require 'ig_markets/sprint_market_position'
require 'ig_markets/version'
require 'ig_markets/watchlist'
require 'ig_markets/working_order'

# This module contains all the code for the IG Markets gem. See `README.md` and the {DealingPlatform} class to get
# started with using this gem.
module IGMarkets
end
