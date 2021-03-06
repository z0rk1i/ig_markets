describe IGMarkets::WorkingOrder, :dealing_platform do
  let(:working_order) { dealing_platform_model build(:working_order, deal_id: '1') }

  it 'reloads itself' do
    expect(dealing_platform.working_orders).to receive(:[]).with('1').twice.and_return(working_order)

    working_order_copy = dealing_platform.working_orders['1'].dup
    working_order_copy.direction = nil
    working_order_copy.reload

    expect(working_order_copy.direction).to eq(:buy)
  end

  it 'deletes itself' do
    result = { deal_reference: 'reference' }

    expect(session).to receive(:delete).with('workingorders/otc/1', nil, IGMarkets::API_V2).and_return(result)

    expect(working_order.delete).to eq('reference')
  end

  it 'updates itself' do
    body = {
      goodTillDate: '2015/10/30 12:59:00',
      level: 1.03,
      limitDistance: 20,
      stopDistance: 30,
      timeInForce: 'GOOD_TILL_DATE',
      type: 'LIMIT'
    }

    put_result = { deal_reference: 'reference' }

    expect(session).to receive(:put).with('workingorders/otc/1', body, IGMarkets::API_V2).and_return(put_result)
    expect(working_order.update(level: 1.03, limit_distance: 20, stop_distance: 30)).to eq('reference')
  end

  it 'fails updating with both a limit distance and a limit level' do
    expect { working_order.update limit_distance: 20, limit_level: 30 }
      .to raise_error(ArgumentError, 'do not specify both limit_distance and limit_level')
  end

  it 'fails updating with both a stop distance and a stop level' do
    expect { working_order.update stop_distance: 20, stop_level: 30 }
      .to raise_error(ArgumentError, 'do not specify both stop_distance and stop_level')
  end
end
