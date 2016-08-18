require 'minitest/autorun'
require 'consistent_company_ruby'

class ConsistentCompanyRubyTest < Minitest::Test
  def test_namer
    # don't change the calling string
    str = ' my test '
    _company = str.namer
    assert_equal(' my test ', str)

    # empty name
    assert_equal("", "".namer)
    assert_equal("", " ".namer)
    assert_equal("", "___".namer)
    # remove leading and trailing space
    assert_equal('TEST', " test ".namer)
    # remove embedded space
    assert_equal('TEST', " te st ".namer)
    # remove Company
    assert_equal("MYTEST", "My Test Company".namer)
    assert_equal("MYCOMPANYTEST", ("MY COMPANY TEST").namer)
    assert_equal("MYTEST", ("MY TEST COMPANY COMP").namer)
    # remove leading The
    assert_equal("AAA", "The AAA Company".namer)
    # remove punctuation
    assert_equal("TESTERS", %q{The, ?%^* tester's company!}.namer)
    # a very long name
    assert_equal("A"*1000+"NAMEISHERE", (" A"*1000 + 'NAME IS HERE ').namer)
    # parenthesis matching
    assert_equal("BBEE", ("BB(xx)EE").namer)
    assert_equal("BE", ("B(xx)E").namer)
    assert_equal("XX", ("(xx)").namer)
    assert_equal("BB", ("BB(xx").namer)
    assert_equal("XX", ("(xx").namer)
    assert_equal("BBMMEE", ("BB(xx)MM(xx)EE").namer)
    assert_equal("BBEE", ("BB(xx(xx)xx)EE").namer)
    assert_equal("BBMM", ("BB(xx)MM(xx").namer)
    assert_equal("BB", ("BB(xx(xx)xx").namer)
    assert_equal("BB", ("BB(xx(xx").namer)

    # handle and &
    assert_equal("PRE&POST", ("pre and post").namer)
    assert_equal("PRE&POST", ("pre & post").namer)
    assert_equal("PRE&POST", ("&pre and post&").namer)
    assert_equal("PRE&POST", ("& pre and post &").namer)
    assert_equal("ANDPRE&POSTAND", ("and pre and post and").namer)

    # leading A
    assert_equal("ABTEST", ("A B TEST").namer)
    assert_equal("BTEST", ("A BTEST").namer)
    assert_equal("APLUSTEST", ("A PLUS TEST").namer)
    assert_equal("APLUSTEST", ("A + TEST").namer)
    assert_equal("APLUSTEST", ("A+ TEST").namer)

    # common name shortening
    assert_equal("TESTCTRCTRCTR", ("Test Center Center Center").namer)
    assert_equal("My Test Advertising Co".namer, "MY TEST ADV COMPANY".namer)

    # rigorous checking
    assert_equal "ABA123&&MCCDAFDS&&B", "aba 123 ~!@\#$%^& *()_+ <>? ,./ {} [] ;' : 'mccdafd s & and b".namer
  end
end
