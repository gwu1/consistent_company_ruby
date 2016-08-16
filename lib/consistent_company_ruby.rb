class ConsistentCompanyRuby
  def self.namer company
    puts company
  end

  def self.transform_company res
    res.gsub! " THE ", " "
    res.gsub! " ONE ", " 1 "
    res.gsub! " TWO ", " 2 "
    res.gsub! " TO ", " 2 "
    res.gsub! " THREE ", " 3 "
    res.gsub! " FOUR ", " 4 "
    res.gsub! " FOR ", " 4 "
    res.gsub! " FIVE ", " 5 "
    res.gsub! " SIX ", " 6 "
    res.gsub! " SEVEN ", " 7 "
    res.gsub! " EIGHT ", " 8 "
    res.gsub! " NINE ", " 9 "
    res.gsub! " TEN ", " 10 "
    res.gsub! " ELEVEN ", " 11 "

    res.gsub! " FIRST ", " 1ST "
    res.gsub! " SECOND ", " 2ND "
    res.gsub! " THIRD ", " 3RD "
    res.gsub! " FOURTH ", " 4TH "
    res.gsub! " FIFTH ", " 5TH "
    res.gsub! " SIXTH ", " 6TH "
    res.gsub! " SEVENTH ", " 7TH "
    res.gsub! " EIGHTH ", " 8TH "
    res.gsub! " NINTH ", " 9TH "
    res.gsub! " TENTH ", " 10TH "
    res.gsub! " CENTRE ", " CTR "
    res.gsub! " CENTER ", " CTR "
    res.gsub! " CNTR ", " CTR "
    res.gsub! " CENT ", " CTR "
    res.gsub! " CENTR ", " CTR "
    res.gsub! " AUTOMOTIVE ", " AUTO "
    res.gsub! " AUTOMOBILE ", " AUTO "
    res.gsub! " AUTOS ", " AUTO "
    res.gsub! " AVENUE ", " AVE "
    res.gsub! " DRIVE ", " DR "
    res.gsub! " PHOTOGRAPHY ", " PHOTO "
    res.gsub! " BROTHERS ", " BROS "
    res.gsub! " TECHNOLOGY ", " TEC "
    res.gsub! " TECH ", " TEC "
    res.gsub! " TELEVISION ", " TV "
    res.gsub! " INFORMATION ", " INFO "
    res.gsub! " SOCIETY ", " SOC "
    res.gsub! " DEPARTMENT ", " DEPT "
    res.gsub! " REGIONAL ", " REG "
    res.gsub! " REGION ", " REG "
    res.gsub! " AUTHORITY ", " AUTH "
    res.gsub! " NATIONAL ", " NATL "
    res.gsub! " INTERNATIONAL ", " INT "
    res.gsub! " INTERNATION ", " INT "
    res.gsub! " INTL ", " INT "
    res.gsub! " MARKETING ", " MKT "
    res.gsub! " MKTG ", " MKT "
    res.gsub! " MANAGEMENT ", " MGT "
    res.gsub! " MGMT ", " MGT "
    
    res.strip!
    space_loc = res.index ' '

    if space_loc && res.size > 3

      # Check for "A" as the first word, and
      # make sure that second word is not an initital or the word "PLUS"
      # For example: "A C & R" do not remove "A"; "A TOUCH OF CLASS" remove the "A"
      if res.start_with?('A ') &&
          !res[2..res.size].start_with?('&') &&
          !res[3..res.size].start_with?(' ') &&
          res.index('PLUS') != res.size + 2
       res.gsub! 'A ', ''
      end

      # Remove last word if it is a company word
      space_loc = res.index ' '
      if space_loc
        res_array = res.split(' ')
        if is_company_word(res_array.last)
          res = res_array.first(res_array.size - 1).join(' ')
        end
      end
    end

    res
  end

  def is_company_word in_word
    if ["ADV","ADVERTISING","AGCY","AGENCY","AGY","ASC","ASS","ASSN","ASSOC","ASSOCIAT","ASSOCIATES","ASSOCIATION","ATTORNEY","ATTRNY","ATTY","ATY","AUTO","CO","COMP","COMPANIES","COMPANY","CORP","CORPORATION","CT","CONTRA","DEPARTMENT","DEPT","DIR","DIRECT","DIV","DIVISION","GROUP","HOLDINGS","INC","INCORPORATED","INT","LIMITED","LLC","LLP","LOCAL","LTD","PC","PLC","PROD","PRODS","PRODUCT","PRODUCTIONS","PRODUCTS","TR","TRADE"].include?(in_word)
      true
    else
      false
    end
  end
end
