# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'rubygems'
require 'motion/project'
require 'bundler'
require 'sugarcube-gestures'
require 'motion-cocoapods'
require 'motion_model'
require 'bubble-wrap'
require 'bubble-wrap/ui'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'JumpShot'
  app.prerendered_icon = true
  app.device_family = [:iphone, :ipad]
  app.pods do 
    pod 'SVPullToRefresh'
  end
end
