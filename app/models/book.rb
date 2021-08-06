class Book < ApplicationRecord
  belongs_to :library, optional: true
  belongs_to :user, optional: true
end
