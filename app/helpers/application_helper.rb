module ApplicationHelper
  def gravatar(author, size)
    email = author.email || extract_email(author.name.to_s) || author.name
    gravatar_image_tag(email, class: "img-rounded", alt: email, gravatar: { size: size })
  end

  def extract_email(txt)
    reg = /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
    txt.scan(reg).uniq.first
  end
end
