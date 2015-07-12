#
# Be sure to run `pod lib lint DMTime.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "DMTime"
  s.version          = "0.1.0"
  s.summary          = "A simple Objective-C timing framework. e.g. A code timer"
  s.description      = <<-DESC
                        #CocoaTime

                        A simple Objective-C timer for timing code.

                        ##Examples

                            [DMTime startTimer:@"Some key"];
                            // Some long running process
                            DMTimeResult *result = [DMTime endTimer:@"Some key"];
                            NSLog(@"Code took %f seconds", [result seconds]);

                        Or if you prefer blocks:

                            DMTimeResult *result = [DMTime timeBlock:^{
                            // Some long running process
                            }];
                            NSLog(@"Code took %f milliseconds", [result milliseconds]);
                       DESC
  s.homepage         = "https://github.com/Vel0x/DMTime"
  s.license          = 'MIT'
  s.author           = { "Vel0x" => "DaleMyers19@gmail.com" }
  s.source           = { :git => "https://github.com/Vel0x/DMTime.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/vel0x'

  s.platform     = :ios, '6.0'
  s.platform     = :osx, '10.8'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'DMTime' => ['Pod/Assets/*.png']
  }

  s.public_header_files = 'Pod/Classes/**/*.h'
end
