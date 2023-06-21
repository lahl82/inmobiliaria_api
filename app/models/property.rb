class Property < ApplicationRecord
  belongs_to :agent

  enum property_type: { house: 0, apartment: 1, annex: 2, shop: 3, shed: 4, lot: 5 }
  enum state: { available: 0, suspended: 1, sold_in: 2, sold_out: 3 }
  enum mode: { sale: 0, rent: 1 }

  # conditional validations for property type

  with_options if: :type_house? do |house|
    house.validates :qty_bathroom, :qty_bedroom, :qty_parking, :qty_floor, :qty_kitchen, :qty_hall, presence: true,
                                                                                                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    house.validates :is_private, :office, :shop, :yard, :garden, :social, inclusion: { in: [true, false] }
  end

  with_options if: :type_apartament_or_annex? do |ap_an|
    ap_an.validates :qty_bathroom, :qty_bedroom, :qty_parking, :qty_kitchen, :qty_hall, :qty_floor, presence: true,
                                                                                                    numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    ap_an.validates :is_private, :social, inclusion: { in: [true, false] }
  end

  with_options if: :type_shop? do |shop|
    shop.validates :qty_bathroom, :qty_floor, presence: true,
                                              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    shop.validates :is_private, :office, inclusion: { in: [true, false] }
  end

  with_options if: :type_shed? do |shed|
    shed.validates :qty_bathroom, :qty_floor, presence: true,
                                              numericality: { only_integer: true, greater_than_or_equal_to: 0 }
    shed.validates :is_private, :office, :shop, :yard, inclusion: { in: [true, false] }
  end

  # required fields validations and data integrity

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :direction, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :mode, presence: true, inclusion: { in: %w[sale rent] }
  validates :property_type, presence: true, inclusion: { in: %w[house apartment annex shop shed lot] }

  def type_house?
    property_type == 'house'
  end

  def type_apartament_or_annex?
    property_type == 'apartment' || property_type == 'annex'
  end

  def type_shop?
    property_type == 'shop'
  end

  def type_shed?
    property_type == 'shed'
  end
end
