class TennisScorer
    PLAYER_RELATION = { saca: :recibe, recibe: :saca }
    SCORE_TRANSLATION = { 0 => 0, 1 => 15, 2 => 30, 3 => 40 }
  
    def initialize
        @score = { saca: 0, recibe: 0 }
    end
  
    def score(player = :saca) 
        other = PLAYER_RELATION[player]
        if @score[player] <= 3 and @score[other] <= 3
            if @score[player] == @score[other] and @score[player] == 3
                'DEUCE'
            else
                "#{SCORE_TRANSLATION[@score[:saca]]}-#{SCORE_TRANSLATION[@score[:recibe]]}"
            end
        elsif @score[player] - @score[other] >= 2
            "W-L"
        elsif @score[other] - @score[player] >= 2
            "L-W"
        elsif @score[other] >= 3 and @score[player] >= 3
            if @score[player] > @score[other]
                "El sacador tiene ventaja"
            elsif @score[player] == @score[other]
                "DEUCE"
            else
                "El receptor tiene ventaja"
            end
        end
    end
  
    def give_point_to(player)
      @score[player] = @score[player] + 1 if @score[player].presence?
    end  
  end