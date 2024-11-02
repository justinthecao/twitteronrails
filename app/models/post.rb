class Post < ApplicationRecord
    has_many :comments, dependent: :destroy
    belongs_to :user
    validates :title, presence: true, length: { minimum: 5 }
    validates :body, presence: true, length: { minimum: 5 }
    validate :antipolitical

    private
    def antipolitical
      forbidden_words = ["trump", "harris", "politics", "election", "government", "president"]
      puts title.downcase
        puts title.downcase.class
        puts body
        # Check if title contains any forbidden words
        title_contains_forbidden = forbidden_words.any? { |word| title.downcase.include?(word)} 
        body_contains_forbidden = forbidden_words.any? { |word| body.downcase.include?(word)} 

        if title_contains_forbidden
          errors.add(:title, "cannot contain political words.")
        end
        if body_contains_forbidden
            errors.add(:body, "cannot contain political words.")
        end
  

      end
end
