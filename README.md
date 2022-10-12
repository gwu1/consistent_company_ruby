# consistent_company_ruby

A pure Ruby implementation of a gem ['consistent_company'](https://github.com/dcleven/consistent_company) that is a Ruby C Extension. Since C-extensions are not really supported in JRuby, for some JRuby users like me, here is an alternative if you want to use 'consistent_company' gem. It takes a Company Name string and replaces it with a normalized compressed version. The replaced name is not for human consumption, but for comparing other similar names to find matches.

## Install:

gem install consistent_company_ruby

## Usage:

A namer method is added to the string class.

	>> require 'consistent_company_ruby'
	=> true
	>> 'First Federal Savings'.namer
	=> '1STFEDERALSAVINGS'
	
# Acknowledgments
- https://github.com/dcleven/consistent_company

# Copyright

See LICENSE.txt for further details.

