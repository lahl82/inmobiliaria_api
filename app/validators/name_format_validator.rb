# app/validators/name_format_validator.rb
class NameFormatValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /\A[\p{L}\s]+\z/
        record.errors.add(attribute, (options[:message] || "solo permite letras y espacios"))
      end
    end
  end
  