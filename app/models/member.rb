require 'csv'

class Member < ActiveRecord::Base

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i

  validates :email, presence: true, uniqueness: true, format: { with: EMAIL_REGEX }, length: { maximum: 128 }
  validates :first_name, presence: true, length: { maximum: 128 }
  validates :last_name, presence: true, length: { maximum: 128 }
  validates :year, presence: true, inclusion: { in:  1..5 }

  def self.import_json(member_array)
    added = 0
    errors = 0
    error_checksums = []
    member_array.each do | json |
      if json
        m = new(email: json['email'], first_name: json['first_name'], last_name: json['last_name'], year: json['year'])
        if m.save
          added += 1
        else
          errors += 1
          error_checksums << json['checksum']
        end
      end
    end
    { added: added, errors: errors, error_checksums: error_checksums }
  end

  def self.to_csv
    CSV.generate do |csv|
      cnames = column_names - ['created_at', 'updated_at']
      csv << cnames
      year_index = cnames.find_index 'year'
      all.each do |member|
        attributes = member.attributes.values_at(*cnames)
        attributes[year_index] = member.year_string
        csv << attributes
      end
    end
  end

  def year_string
    ['I', 'II', 'III', 'IV', 'Postgrad/Staff'][year - 1]
  end
end
