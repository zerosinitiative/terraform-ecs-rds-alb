title 'AWS cloudwatch log group test'

log_group = attribute('log_group')

control 'cloudwatch' do
    impact 1.0
    title 'Ensure that the cloudwatch log group exists'
    describe aws_cloudwatch_log_group(log_group) do
        it { should exist }
    end
end