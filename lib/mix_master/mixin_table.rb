module MixMaster
  class MixinTable
    def initialize
      @list = {}
    end

    def set(source, target, source_dup)
      @list[source] ||= {}
      @list[source][target] = source_dup
    end

    def exists?(from, to)
      get(from, to) ? true : false
    end

    def get(from, to)
      @list[from] && @list[from][to]
    end
  end
end