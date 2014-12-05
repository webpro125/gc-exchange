module RegexConstants
  EMAIL =  Devise.email_regexp

  module Letters
    ONLY          = /\A[a-zA-Z]+\z/
    AND_SPECIAL   = /\A[a-zA-Z\s]+\z/
    AND_DASHES    = /\A[A-Za-z\s'-]+\z/
    AND_NUMBERS   = /\A[a-zA-Z0-9\s'-]+\z/
  end

  module Words
    AND_SPECIAL   = /\A[\w\s'-]+\z/
    ONLY          = /\A[\w\s\.-]+\z/
  end

  module Numbers
    AS_ZIPCODE = /\A[\d]+\z/
  end

  module FileTypes
    AS_DOCUMENTS  = ['application/pdf']
  end

  module ImageTypes
    AS_IMAGES = ['image/jpg',
                 'image/png',
                 'image/jpeg']
  end
end
