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
  app.name = 'JumpShot'
  app.prerendered_icon = true
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait]
  
  # For facebook integration 
  # app.frameworks += %w{ AdSupport Accounts Social}
  # app.identifier = 'com.jon.test-app'
  # app.info_plist['FacebookAppID'] = 514585911935812
  # app.info_plist['CFBundleURLTypes'] = [{'CFBundleURLSchemes' => ["fb514585911935812"]}]
  app.pods do 
    pod 'SVPullToRefresh'
    # pod 'Facebook-iOS-SDK'
  end
end
