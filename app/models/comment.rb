class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :body, presence: true, length: { minimum: 5 }
  validate :antipolitical
  private
  def antipolitical
    forbidden_words = ["trump", "harris", "politics", "election", "government", "president"]
    # Check if title contains any forbidden words
    body_contains_forbidden = forbidden_words.any? { |word| body.downcase.include?(word)} 
    if body_contains_forbidden
        errors.add(:body, "cannot contain political words.")
    end


  end
end
