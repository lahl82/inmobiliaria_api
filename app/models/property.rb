class Property < ApplicationRecord
  belongs_to :agent

  enum property_type: { house: 0, apartment: 1, annex: 2, shop: 3, shed: 4 }
  enum state: { available: 0, suspended: 1, sold_in: 2, sold_out: 3 }
  enum mode: { sale: 0, rent: 1 }

  # conditional validations for property type

  validates :is_private, :qty_bathroom, :qty_bedroom, :qty_parking, :qty_floor, :qty_kitchen, :qty_hall, :office, :shop,
            :yard, :garden, :social, presence: true, if: :type_house?
  validates :is_private, :qty_bathroom, :qty_bedroom, :qty_parking, :qty_kitchen, :qty_hall, :qty_floor, :social,
            presence: true, if: :type_apartament_or_annex?
  validates :is_private, :qty_bathroom, :qty_floor, :office, presence: true,
                                                             if: :type_shop?
  validates :is_private, :qty_bathroom, :qty_floor, :office, :shop, :yard, presence: true,
                                                                           if: :type_shed?

  # required fields validations and data integrity

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :direction, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :qty_bedroom, :qty_bathroom, :qty_floor, :qty_kitchen, :qty_parking, :qty_hall,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :office, :shop, :yard, :garden, :social, :is_private, inclusion: { in: [true, false] }
  validates :mode, presence: true, inclusion: { in: %i[sale rent] }

  def type_house?
    property_type == :house
  end

  def type_apartament_or_annex?
    property_type == :apartment || property_type == :annex
  end

  def type_shop?
    property_type == :shop
  end

  def type_shed?
    property_type == :shed
  end
end
