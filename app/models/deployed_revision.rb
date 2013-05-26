
class DeployedRevision
  def initialize(url, extract_regex)
    @url, @extract_regex = url, Regexp.compile(extract_regex)
  end

  def fetch
    response = retriable(interval: 3) { HTTParty.get(@url) }
    if response.code == 200
      html = Nokogiri::HTML(response.body)
      html.at('body').inner_text =~ @extract_regex
      $1 || "Nothing matched"
    else
      "Got unexpected response (code: #{response.code}) for url: #{@url}"
    end
  end
end
