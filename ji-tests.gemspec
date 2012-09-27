# -*- ruby -*- encoding: utf-8 -*-

gem 'rjack-tarpit', '~> 2.0'
require 'rjack-tarpit/spec'

RJack::TarPit.specify do |s|
  s.version = "0.1.0"

  s.add_developer( 'David Kellum', 'dek-oss@gravitext.com' )

  s.depend 'minitest', '~> 3.2.0', :dev

  s.maven_strategy = :no_assembly
end
