module RegexLibrary
  LETTERS = {
    'only'       => /\A[a-zA-Z]+\z/,
    'and spaces' => /\A[a-zA-Z\s]+\z/,
    'and dashes' => /\A[A-Za-z\s'-]+\z/
  }
  WORDS = {
    'and special' => /\A[\w\s'-]+\z/,
    'only'        => /\A[\w\s\.-]+\z/
  }
  NUMBERS = {
    'as a zipcode' => /\A[\d]+\z/
  }
  FILE_TYPES = {
    'as documents' => [/doc\Z/, /docx\Z/, /pdf\Z/]
  }
  EMAIL = {
    'only' => Devise.email_regexp
  }
end
