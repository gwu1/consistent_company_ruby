module ConsistentCompanyRuby
  module InstanceMethods
    def namer# company
      return self if self == ''

      in_string = self.dup

      # while processing we turn & = AND, + = PLUS
      # and we add space at front and back
      in_string.gsub('&',' & ')
      in_string.gsub('+',' + ')

      in_string = in_string.upcase
      in_string.strip!

      # in_string.gsub(/\(|\)/,' ')
      num_lefts = 0
      num_rights = 0
      left1 = -1
      right1 = -1
      left2 = -1
      right2 = -1
      len = in_string.size

      (0..len-1).each do |i|
        if in_string[i] == '('
          num_lefts += 1
          if num_lefts == 1
            left1 = i
          elsif num_lefts == 2
            left2 = i
          end
        elsif in_string[i] == ')'
          num_rights += 1
          if num_rights == 1
            right1 = i
          elsif num_rights == 2
            right2 = i
          end
        end
      end

      if num_lefts == 0 || in_string[0] == '('
        # Do Nothing
	    elsif num_lefts == 1
  	  	if right1 > left1
          # ..(xx).. -> ....
          in_string = "#{in_string[0..left1-1]}#{in_string[right1+1..len-1]}"
        else
          # ..(xx -> ..
          in_string = in_string[0..left1-1]
        end
      elsif num_lefts == 2
        if (left1 < right1) && (right1 < left2) && (left2 < right2)
          # ..(xx)..(xx).. -> ......
          in_string = "#{in_string[0..left1-1]}#{in_string[right1+1..left2-1]}#{in_string[right2+1..len-1]}"
        elsif (left1 < left2) && (left2 < right1) && (right1 < right2)
          # ..(xx(xx)xx).. -> ....
          in_string = "#{in_string[0..left1-1]}#{in_string[right2+1..len-1]}"
        elsif (left1 < right1) && (right1 < left2) && (right2 == -1)
          # ..(xx)..(xx -> ....
          in_string = "#{in_string[0..left1-1]}#{in_string[right1+1..left2-1]}"
        elsif (left1 < left2) && (left2 < right1) && (right2 == -1)
          # ..(xx(xx)xx -> ..
          in_string = in_string[0..left1-1]
        elsif (right1 == -1) && (right2 == -1)
          # ..(xx(xx -> ..
          in_string = in_string[0..left1-1]
        end
      end

      return_string = ''
      (0..in_string.size-1).each do |i|
        ch = in_string[i]
        asc = ch.ord

        if (asc >= 65 && asc <= 90) ||
            (asc >= 48 && asc <= 57) ||
            asc > 128 # A-Z, 0-9, and high order chars
          return_string = "#{return_string}#{ch}"
        elsif asc == 39 # '
          # not keeping it
        elsif asc == 38 && return_string.size > 0 # &
          if return_string[return_string.size-1] != ' '
            return_string = "#{return_string} AND "
          else
            return_string = "#{return_string}AND "
          end
        elsif asc == 43 # +
          if return_string == 'A' || return_string == 'A '
            return_string = 'A PLUS '
          elsif return_string.size > 0
            if return_string[return_string.size-1] != ' '
              return_string = "#{return_string} AND "
            else
              return_string = "#{return_string}AND "
            end
          end
        elsif return_string.size > 0 &&
               return_string[return_string.size-1] != ' '
          return_string = "#{return_string} "
        end
        # puts "#{i}#{ch}#{asc}:#{return_string}"
      end

      return '' if return_string.nil? || return_string == ''

      str_replace return_string, ' AND ', ' & '

      return_string.strip!
      return_string = transform_company return_string
      return_string.strip!
      return_string.gsub!(' ','')
      return_string
    end

    def transform_company res
      res = " #{res} "
      str_replace res,  " THE ", " "
      str_replace res,  " ONE ", " 1 "
      str_replace res,  " TWO ", " 2 "
      str_replace res,  " TO ", " 2 "
      str_replace res,  " THREE ", " 3 "
      str_replace res,  " FOUR ", " 4 "
      str_replace res,  " FOR ", " 4 "
      str_replace res,  " FIVE ", " 5 "
      str_replace res,  " SIX ", " 6 "
      str_replace res,  " SEVEN ", " 7 "
      str_replace res,  " EIGHT ", " 8 "
      str_replace res,  " NINE ", " 9 "
      str_replace res,  " TEN ", " 10 "
      str_replace res,  " ELEVEN ", " 11 "

      str_replace res,  " FIRST ", " 1ST "
      str_replace res,  " SECOND ", " 2ND "
      str_replace res,  " THIRD ", " 3RD "
      str_replace res,  " FOURTH ", " 4TH "
      str_replace res,  " FIFTH ", " 5TH "
      str_replace res,  " SIXTH ", " 6TH "
      str_replace res,  " SEVENTH ", " 7TH "
      str_replace res,  " EIGHTH ", " 8TH "
      str_replace res,  " NINTH ", " 9TH "
      str_replace res,  " TENTH ", " 10TH "
      str_replace res,  " CENTRE ", " CTR "
      str_replace res,  " CENTER ", " CTR "
      str_replace res,  " CNTR ", " CTR "
      str_replace res,  " CENT ", " CTR "
      str_replace res,  " CENTR ", " CTR "
      str_replace res,  " AUTOMOTIVE ", " AUTO "
      str_replace res,  " AUTOMOBILE ", " AUTO "
      str_replace res,  " AUTOS ", " AUTO "
      str_replace res,  " AVENUE ", " AVE "
      str_replace res,  " DRIVE ", " DR "
      str_replace res,  " PHOTOGRAPHY ", " PHOTO "
      str_replace res,  " BROTHERS ", " BROS "
      str_replace res,  " TECHNOLOGY ", " TEC "
      str_replace res,  " TECH ", " TEC "
      str_replace res,  " TELEVISION ", " TV "
      str_replace res,  " INFORMATION ", " INFO "
      str_replace res,  " SOCIETY ", " SOC "
      str_replace res,  " DEPARTMENT ", " DEPT "
      str_replace res,  " REGIONAL ", " REG "
      str_replace res,  " REGION ", " REG "
      str_replace res,  " AUTHORITY ", " AUTH "
      str_replace res,  " NATIONAL ", " NATL "
      str_replace res,  " INTERNATIONAL ", " INT "
      str_replace res,  " INTERNATION ", " INT "
      str_replace res,  " INTL ", " INT "
      str_replace res,  " MARKETING ", " MKT "
      str_replace res,  " MKTG ", " MKT "
      str_replace res,  " MANAGEMENT ", " MGT "
      str_replace res,  " MGMT ", " MGT "

      res.strip!
      space_loc = res.index ' '

      if space_loc && res.size > 3

        # Check for "A" as the first word, and
        # make sure that second word is not an initital or the word "PLUS"
        # For example: "A C & R" do not remove "A"; "A TOUCH OF CLASS" remove the "A"
        if res.start_with?('A ') &&
            !res[2..res.size].start_with?('&') &&
            !res[3..res.size].start_with?(' ') &&
            !res[2..res.size].start_with?('PLUS')
         res.gsub! 'A ', ''
        end

        # Remove last word if it is a company word or &
        space_loc = res.index ' '
        if space_loc
          res_array = res.split(' ')
          if is_company_word(res_array.last)
            res_array.pop
            if is_company_word(res_array.last) # Look at the new last word
              res_array.pop
            end
            res = res_array.join(' ')
          end

          res = res[0..res.size-2] if res.end_with? '&'
        end
      end

      res
    end

    def is_company_word(in_word)
      if ["ADV","ADVERTISING","AGCY","AGENCY","AGY","ASC","ASS","ASSN","ASSOC","ASSOCIAT","ASSOCIATES","ASSOCIATION","ATTORNEY","ATTRNY","ATTY","ATY","AUTO","CO","COMP","COMPANIES","COMPANY","CORP","CORPORATION","CT","CONTRA","DEPARTMENT","DEPT","DIR","DIRECT","DIV","DIVISION","GROUP","HOLDINGS","INC","INCORPORATED","INT","LIMITED","LLC","LLP","LOCAL","LTD","PC","PLC","PROD","PRODS","PRODUCT","PRODUCTIONS","PRODUCTS","TR","TRADE"].include?(in_word)
        true
      else
        false
      end
    end

    # It's more than a gsub
    def str_replace(orig, rep, with)
      s = orig
      while s.include?(rep)
        s.sub! rep, with
      end
      orig
    end
  end
end
