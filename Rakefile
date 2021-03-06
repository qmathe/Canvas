# frozen_string_literal: true

PROJECT = 'Canvas.xcodeproj'
CARTHAGE_PLATFORM = 'iOS'
CARTHAGE_VERSION = '0.31.2'
SWIFTLINT_VERSION = '0.24.2'
XCODE_SHORT_VERSION = '10.1'
XCODE_VERSION = '10B61'
XCODEGEN_VERSION = '2.0.0'

desc 'Generate the Xcode project'
task project: :'check:xcodegen' do
  sh 'xcodegen --quiet'
end

desc 'Bootstrap Carthage dependencies and generate the project'
task bootstrap: %i[check:xcode check:carthage project] do
  sh %(carthage bootstrap --platform #{CARTHAGE_PLATFORM})
end

desc 'Update Carthage dependencies'
task update: :'check:carthage' do
  sh %(carthage update --platform #{CARTHAGE_PLATFORM})
end

desc 'Run swiftlint'
task :lint do
  sh 'swiftlint'
end

desc 'Clean everything'
task :clean do
  quit_xcode
  sh %(rm -rf #{PROJECT} Carthage)
end

namespace :check do
  desc 'Check Xcode version'
  task :xcode do
    # Check for Xcode
    unless (path = `xcode-select -p`.chomp)
      fail %(Xcode is not installed. Please install Xcode #{XCODE_SHORT_VERSION} from https://developer.apple.com/download)
    end

    # Check Xcode version
    info_path = File.expand_path path + '/../Version'
    unless (version = `defaults read #{info_path} ProductBuildVersion`.chomp) == XCODE_VERSION
      fail %(Xcode #{version} is installed. Xcode #{XCODE_VERSION} was expected. Please install Xcode #{XCODE_SHORT_VERSION} from https://developer.apple.com/download)
    end
  end

  desc 'Check Carthage version'
  task :carthage do
    unless (version = `carthage version`.chomp) == CARTHAGE_VERSION
      fail %(Carthage #{CARTHAGE_VERSION} isnt’t installed. You can install with `brew install carthage`. You may need to update Homebrew with `brew update` first.)
    end
  end

  desc 'Check XcodeGen version'
  task :xcodegen do
    unless (version = `xcodegen -v`.chomp) == XCODEGEN_VERSION
      fail %(XcodeGen #{XCODEGEN_VERSION} isnt’t installed. You can install with `brew install xcodegen`. You may need to update Homebrew with `brew update` first.)
    end
  end

  desc 'Check swiftlint version'
  task :swiftlint do
    unless (version = `swiftlint version`.chomp) == SWIFTLINT_VERSION
      fail %(swiftline #{SWIFTLINT_VERSION} isnt’t installed. You can install with `brew install swiftlint`. You may need to update Homebrew with `brew update` first.)
    end
  end
end
