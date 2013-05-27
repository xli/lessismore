class DeployedRevision < ActiveRecord::Base
  def self.fetch(url, extract_regex_str)
    extract_regex = Regexp.compile(extract_regex_str)

    response = retriable(interval: 3) { HTTParty.get(url) }
    if response.code == 200
      html = Nokogiri::HTML(response.body)
      html.at('body').inner_text =~ extract_regex
      $1 || "Nothing matched"
    else
      "Got unexpected response (code: #{response.code}) for url: #{url}"
    end
  end

  belongs_to :continuous_deployment
end
