# frozen_string_literal: true

require_relative 'entry'

class EntryList
  include Enumerable

  def initialize(items)
    @entries = items.map { |item| item.is_a?(String) ? Entry.new(item) : item }
  end

  def each(&block)
    @entries.each(&block)
  end

  def sort_by_name
    EntryList.new(@entries.sort_by(&:file_name))
  end

  def remove_hidden
    EntryList.new(@entries.reject(&:hidden?))
  end

  def reverse
    EntryList.new(@entries.reverse)
  end

  def size
    @entries.size
  end

  def [](index)
    @entries[index]
  end
end
