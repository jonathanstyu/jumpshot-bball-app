# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'rubygems'
require 'motion/project'
require 'bundler'
require 'sugarcube-gestures'
require 'motion-cocoapods'
require 'motion_model'
require 'bubble-wrap'
require 'motion-testflight'
require 'nano-store'
Bundler.require

Motion::Project::App.setup do |app|
  app.name = 'JumpShot'
  app.version = "1.0"
  app.prerendered_icon = true
  app.device_family = [:iphone, :ipad]
  app.interface_orientations = [:portrait]
  app.frameworks += %w{ AddressBook, AddressBookUI, MessageUI }
  app.identifier = 'net.jonathanyu.jumpshot'
  app.codesign_certificate = 'iPhone Distribution: Jonathan Yu'
  app.provisioning_profile = '/Users/jonathan/Desktop/jumpshotappstore.mobileprovision'
  app.testflight do 
    app.testflight.sdk = 'vendor/TestFlight'
    app.testflight.app_token = 'b358f1b4-fe79-43aa-9ce9-78417fc89d87'
    app.testflight.api_token = 'aaf11f8defb243f4ce126b04e65e7805_MTAzMTY3MjIwMTMtMDUtMDYgMTg6MTY6NTguMzgyMzIy'
    app.testflight.team_token = 'd5588d6b67c9f33ecef2e9d836dfa397_MjIwMjIzMjAxMy0wNS0wNiAxODoyMTowMS41NTM1MjE'
    app.testflight.notify = true
    app.testflight.identify_testers = true
  end
  app.development do
    app.entitlements['get-task-allow'] = false
  end
  # For facebook integration 
  # app.info_plist['FacebookAppID'] = 514585911935812
  # app.info_plist['CFBundleURLTypes'] = [{'CFBundleURLSchemes' => ["fb514585911935812"]}]
  app.pods do 
    pod 'SVPullToRefresh'
    pod 'MCSwipeTableViewCell'
    pod 'NanoStore'
    # pod 'NUI'
    # pod 'Facebook-iOS-SDK'
  end
end
