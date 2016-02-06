require File.expand_path('../lib/omniauth/surveymonkey/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'

  gem.authors = ["Waqas Ali"]
  gem.email = ["wqsaali@gmail.com"]
  gem.description = %q{Survemonkey OAuth2 strategy for OmniAuth 1.0}
  gem.summary = %q{Survemonkey OAuth2 strategy for OmniAuth 1.0.}


  gem.files = `git ls-files`.split("\n")
  gem.test_files = `git ls-files spec/*`.split("\n")
  gem.name = "surveymonkey-with-omniauth"
  gem.require_paths = ["lib"]
  gem.version = OmniAuth::Surveymonkey::VERSION
  gem.homepage = "https://github.com/wqsaali/surveymonkey-with-omniauth"

  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'rspec', '~> 1.3.1'
  gem.add_development_dependency 'rake'
end