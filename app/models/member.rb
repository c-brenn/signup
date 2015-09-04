class Member < ActiveRecord::Base

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }, length: { maximum: 128 }
  validates :first_name, presence: true, length: { maximum: 128 }
  validates :last_name, presence: true, length: { maximum: 128 }
  validates :year, presence: true, inclusion: { in:  1..5 }

  def self.import_json(member_array)
    added = 0
    errors = 0
    member_array.each do | json |
      if json
        m = new(email: json['email'], first_name: json['first_name'], last_name: json['last_name'], year: json['year'])
        if m.save
          added += 1
        else
          errors += 1
        end
      end
    end
    { added: added, errors: errors }
  end

end
