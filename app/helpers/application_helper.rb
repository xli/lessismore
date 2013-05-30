module ApplicationHelper
  def gravatar(author, size)
    email = author.email.strip.downcase
    code = Rails.cache.fetch("avatar:#{email}", :expires_in => 1.hour) do
      HTTParty.get(GravatarImageTag::gravatar_url(email, default: 404)).code
    end
    if code == 404
      content_tag('div', email, class: 'default-avatar')
    else
      gravatar_image_tag(email, class: "img-rounded", alt: author.email, gravatar: { size: size })
    end
  end

  def extract_email(txt)
    reg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    txt.scan(reg).uniq.first
  end
end
