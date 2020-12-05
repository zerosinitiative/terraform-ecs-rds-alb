title 'AWS LB test'

alb_arn = attribute('alb_arn')

control 'lb' do
    impact 1.0
    title 'Ensure that the load balancer exists'
    describe aws_alb(load_balancer_arn: alb_arn) do
        it { should exist }
    end  
end