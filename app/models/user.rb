class User < ApplicationRecord
  has_many :posts, deprecated: true

  def to_markdown
    email
  end
end
