require File.expand_path('../lib/omniauth/surveymonkey/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth'
  gem.add_dependency 'oauth2'
  gem.add_dependency 'omniauth-oauth2'

  gem.add_development_dependency 'rspec', '~> 2.7'
  gem.add_development_dependency 'rack-test'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'

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
  gem.license = 'MIT'
end
