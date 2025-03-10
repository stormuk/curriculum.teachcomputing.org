Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN')
  config.breadcrumbs_logger = %i[sentry_logger active_support_logger]
  config.traces_sample_rate = 0.25
  config.enabled_environments = %w[staging production]
end
