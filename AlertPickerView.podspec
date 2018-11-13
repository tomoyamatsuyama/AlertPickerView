Pod::Spec.new do |spec|
  spec.name         = 'AlertPickerView'
  spec.version      = '0.1.2'
  spec.license      = { :type => 'MIT', :file => 'LICENSE' }
  spec.homepage     = 'https://github.com/tomoyamatsuyama/AlertPickerView'
  spec.authors      = { 'Tomoya Matsuyama' => 'm.tomoya0221@gmail.com' }
  spec.summary      = 'Present pickerView like AlertController'
  spec.source       = { :git => 'https://github.com/tomoyamatsuyama/AlertPickerView.git', :tag => spec.version.to_s }
  spec.source_files = 'AlertPickerView/*.{swift}'
  spec.resource_bundles = {
    'AlertPickerView' => ['AlertPickerView/*.storyboard']
  }
  spec.dependency 'RxSwift'
  spec.dependency 'RxCocoa'
  spec.ios.deployment_target = "11.0"

end
