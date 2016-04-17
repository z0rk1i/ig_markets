describe IGMarkets::CLI::Positions do
  let(:dealing_platform) { IGMarkets::DealingPlatform.new }

  def cli(arguments = {})
    IGMarkets::CLI::Positions.new [], arguments
  end

  before do
    expect(IGMarkets::CLI::Main).to receive(:begin_session).and_yield(dealing_platform)
  end

  it 'prints positions' do
    positions = [build(:position)]

    expect(dealing_platform.positions).to receive(:all).and_return(positions)

    expect { cli.list }.to output(<<-END
deal_id: +10.4 of CS.D.EURUSD.CFD.IP at 100.0, profit/loss: USD 0.00
END
                                 ).to_stdout
  end

  it 'creates a new position' do
    arguments = {
      currency_code: 'USD',
      direction: 'buy',
      epic: 'CS.D.EURUSD.CFD.IP',
      size: 2
    }

    deal_confirmation = build :deal_confirmation

    expect(dealing_platform.positions).to receive(:create).with(arguments).and_return('ref')
    expect(dealing_platform).to receive(:deal_confirmation).with('ref').and_return(deal_confirmation)

    expect { cli(arguments).create }.to output(<<-END
Deal reference: ref
Deal confirmation: deal_id, accepted, affected deals: , epic: CS.D.EURUSD.CFD.IP
END
                                              ).to_stdout
  end

  it 'updates a position' do
    arguments = {
      limit_level: 20,
      stop_level: 30
    }

    position = build :position
    deal_confirmation = build :deal_confirmation

    expect(dealing_platform.positions).to receive(:[]).with('deal_id').and_return(position)
    expect(position).to receive(:update).with(arguments).and_return('ref')
    expect(dealing_platform).to receive(:deal_confirmation).with('ref').and_return(deal_confirmation)

    expect { cli(arguments).update('deal_id') }.to output(<<-END
Deal reference: ref
Deal confirmation: deal_id, accepted, affected deals: , epic: CS.D.EURUSD.CFD.IP
END
                                              ).to_stdout
  end

  it 'closes a position' do
    arguments = { size: 1 }

    position = build :position
    deal_confirmation = build :deal_confirmation

    expect(dealing_platform.positions).to receive(:[]).with('deal_id').and_return(position)
    expect(position).to receive(:close).with(arguments).and_return('ref')
    expect(dealing_platform).to receive(:deal_confirmation).with('ref').and_return(deal_confirmation)

    expect { cli(arguments).close('deal_id') }.to output(<<-END
Deal reference: ref
Deal confirmation: deal_id, accepted, affected deals: , epic: CS.D.EURUSD.CFD.IP
END
                                              ).to_stdout
  end
end
