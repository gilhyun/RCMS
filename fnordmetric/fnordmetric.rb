require "fnordmetric"

FnordMetric.namespace :myapp do

  FnordMetric.options={enable_active_users: false}

  # render a timeseries graph
  widget 'Sales',
    :title => "Sales per Minute",
    :gauges => [:sales_per_minute, :sales_per_minute2],
    :type => :timeline,
    :width => 100,
    :autoupdate => 1,
    :resolution => 1.second

end

FnordMetric.standalone
