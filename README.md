# consistent_company_ruby

A native Ruby implementation of a Ruby gem 'consistent_company' that is a Ruby C Extension. It takes a Company Name string and replaces it with a normalized compressed version. The replaced name is not for human consumption, but for comparing other similar names to find matches.

## Install:

gem install consistent_company_ruby

## Usage:

A namer method is added to the string class.

	>> require 'consistent_company_ruby'
	=> true
	>> 'First Federal Savings'.namer
	=> '1STFEDERALSAVINGS'