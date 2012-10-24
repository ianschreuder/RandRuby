require 'rsruby'
require 'rsruby/dataframe'
$rsruby = RSRuby.instance
$rsruby.class_table['data.frame'] = lambda {|x| DataFrame.new(x)}
RSRuby.set_default_mode(RSRuby::CLASS_CONVERSION)
$rsruby.source(Rails.root.to_s + '/lib/R/functions.R')