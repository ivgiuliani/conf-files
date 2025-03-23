function staging
  cd ~/gocardless/payments-service ; bundle exec cap live-staging docker:console
end
