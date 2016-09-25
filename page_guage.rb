class PageGuage
  attr_accessor :queries, :pages
  IDENTIFIERS = {page: 'P', query: 'Q'}

  def initialize(raw_str, max_weight)
    @unprocessed_str = raw_str
    @max_weight = max_weight
    @pages, @queries = split_queries_and_pages
  end

  def result
    final_result = ''

    query_weights = queries.each.with_index(1) do |query, ix|
      wt_analysis = sort_pages_by_weights(pages, query)
      final_result += "Q#{ix}: #{wt_analysis}\n"
    end

    final_result
  end

  private

  def sort_pages_by_weights(pages, query)
    page_weight = {}
    pg_wt = ''

    pages.each.with_index(1) do |page, page_ix|
      page_weight["P#{page_ix}"] = weigh_page_for_query(page, query, page_ix)
    end

    page_weight.sort_by { |k, v| v }.reverse!.each do |weighed_page|
      pg_wt += " #{weighed_page[0]}" if weighed_page[1] > 0
    end

    pg_wt
  end

  def weigh_page_for_query(page, query, page_index = 1)
    page_weight = 0

    page.each_with_index do |page_keyword, p_ix|
      query.each_with_index do |query_keyword, q_ix|
        if page_keyword.match(/#{query_keyword}+$/i)
          page_weight += (@max_weight - p_ix) * (@max_weight - q_ix)
        end
      end
    end

    page_weight
  end

  def split_queries_and_pages
    in_process_str = @unprocessed_str.split("\n")

    in_process_str.each_with_index do |str, index|
      in_process_str.delete_at(index) if str.nil? || str.empty?
    end

    return split_entities(in_process_str)
  end

  def split_entities(str_arr)
    page, query = [], []
    pid, qid = IDENTIFIERS[:page], IDENTIFIERS[:query]

    str_arr.each_with_index do |str, ix|
      str.strip!

      if str.start_with?(pid)
        page << str.gsub(/^\s*#{pid}\s/, '').strip.split
      elsif str.start_with?(qid)
        query << str.gsub(/^\s*#{qid}\s/, '').strip.split
      end
    end

    [page, query]
  end
end
