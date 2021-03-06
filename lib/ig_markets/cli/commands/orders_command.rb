module IGMarkets
  module CLI
    # Implements the `ig_markets orders` command.
    class Orders < Thor
      desc 'list', 'Prints working orders'

      def list
        Main.begin_session(options) do |dealing_platform|
          working_orders = dealing_platform.working_orders.all

          table = Tables::WorkingOrdersTable.new working_orders

          puts table
        end
      end

      default_task :list

      desc 'create', 'Creates a new working order'

      option :currency_code, required: true, desc: "The 3 character currency code, must be one of the instrument's " \
                                                   'currencies'
      option :direction, enum: %w[buy sell], required: true, desc: 'The trade direction'
      option :epic, required: true, desc: 'The EPIC of the market to trade'
      option :expiry, desc: 'The expiry date of the instrument (if applicable), format: yyyy-mm-dd'
      option :force_open, type: :boolean, default: true, desc: 'Whether a force open is required'
      option :good_till_date, desc: 'The date that the order will live till, format: yyyy-mm-ddThh:mm(+|-)zz:zz'
      option :guaranteed_stop, type: :boolean, default: false, desc: 'Whether a guaranteed stop is required'
      option :level, type: :numeric, required: true, desc: 'The level at which the order will be triggered'
      option :limit_distance, type: :numeric, desc: 'The distance away in pips to place the limit'
      option :limit_level, type: :numeric, desc: 'The level at which to place the limit'
      option :size, type: :numeric, required: true, desc: 'The size of the order'
      option :stop_distance, type: :numeric, desc: 'The distance away in pips to place the stop'
      option :stop_level, type: :numeric, desc: 'The level at which to place the stop'
      option :type, enum: %w[limit stop], required: true, desc: 'The order type'

      def create
        Main.begin_session(options) do |dealing_platform|
          deal_reference = dealing_platform.working_orders.create working_order_attributes

          Main.report_deal_confirmation deal_reference
        end
      end

      desc 'update DEAL-ID', 'Updates an existing working order'

      option :good_till_date, desc: 'The date that the order will live till, format: yyyy-mm-ddThh:mm(+|-)zz:zz'
      option :level, type: :numeric, desc: 'The level at which the order will be triggered'
      option :limit_distance, desc: 'The distance away in pips to place the limit'
      option :limit_level, type: :numeric, desc: 'The level at which to place the limit'
      option :stop_distance, desc: 'The distance away in pips to place the stop'
      option :stop_level, type: :numeric, desc: 'The level at which to place the stop'
      option :type, enum: %w[limit stop], desc: 'The order type'

      def update(deal_id)
        Main.begin_session(options) do |dealing_platform|
          working_order = dealing_platform.working_orders[deal_id]

          raise 'No working order with the specified deal ID' unless working_order

          deal_reference = working_order.update working_order_attributes

          Main.report_deal_confirmation deal_reference
        end
      end

      desc 'delete DEAL-ID', 'Deletes the working order with the specified deal ID'

      def delete(deal_id)
        Main.begin_session(options) do |dealing_platform|
          working_order = dealing_platform.working_orders[deal_id]

          raise 'No working order with the specified deal ID' unless working_order

          deal_reference = working_order.delete

          Main.report_deal_confirmation deal_reference
        end
      end

      desc 'delete-all', 'Deletes all working orders'

      def delete_all
        Main.begin_session(options) do |dealing_platform|
          dealing_platform.working_orders.all.each do |working_order|
            deal_reference = working_order.delete

            Main.report_deal_confirmation deal_reference
          end
        end
      end

      private

      ATTRIBUTES = %i[currency_code direction epic expiry force_open good_till_date guaranteed_stop level
                      limit_distance limit_level size stop_distance stop_level type].freeze

      def working_order_attributes
        attributes = Main.filter_options options, ATTRIBUTES

        Main.parse_date_time attributes, :expiry, Date, '%F', 'yyyy-mm-dd'
        Main.parse_date_time attributes, :good_till_date, Time, '%FT%R%z', 'yyyy-mm-ddThh:mm(+|-)zz:zz'

        attributes
      end
    end
  end
end
