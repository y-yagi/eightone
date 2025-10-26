class User < ApplicationRecord
  def to_markdown
    email
  end
end
