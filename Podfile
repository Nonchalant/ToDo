platform :ios, '9.0'
swift_version = '3.1'
use_frameworks!

target 'ToDo' do
  pod 'RxSwift'
  pod 'Swinject'
  pod 'SwinjectStoryboard'

  target 'Presentation' do
    pod 'RxCocoa'

    target 'PresentationTests' do
      inherit! :search_paths
      pod 'Quick'
      pod 'Nimble'
      pod 'RxTest'
    end
  end

  target 'Domain' do
    target 'DomainTests' do
      inherit! :search_paths
      pod 'Quick'
      pod 'Nimble'
      pod 'RxBlocking'
    end
  end

  target 'Infrastructure' do
    pod 'RealmSwift'

    target 'InfrastructureTests' do
      inherit! :search_paths
      pod 'Quick'
      pod 'Nimble'
      pod 'RxBlocking'
    end
  end

  target 'Utility' do
    pod 'SwiftyBeaver'
  end
end
