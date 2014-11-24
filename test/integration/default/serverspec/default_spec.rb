require 'spec_helper'

describe 'rabbitmq_with_conjur' do
    it 'should set the user/pass as default guest:guest' do
        rabbitmq_config = file('/etc/rabbitmq/rabbitmq.config')

        expect(rabbitmq_config).to_not contain 'guest'
    end
end
