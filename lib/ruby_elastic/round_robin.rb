# frozen_string_literal: true

module RubyElastic
  class RoundRobin
    def self.round_robin(n, ps = nil)
      k, j, i = nil
      rs = []

      unless ps
        ps = []
        (k || 1).upto(n).map { |i| ps << i }
      else
        ps = ps.dup
      end

      if ((n % 2) == 1)
        ps.push(-1)
        n += 1
      end

      (j || 0).upto(n - 2) do |i|
        rs[i] = []
        (i || 0).upto((n / 2) - 1) do |j|
          if(ps[j] != -1 && ps[n - 1 - j] != -1)
            rs[i] << [ps[j], ps[n - 1 - j]]
          end
        end
        ps.insert(1, ps.pop)
      end
      rs
    end
  end
end
