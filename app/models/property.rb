class Property < ApplicationRecord
  belongs_to :agent

  enum type: { house: 0, apartment: 1, annex: 2, shop: 3, shed: 4 }
  enum state: { available: 0, suspended: 1, sold_in: 2, sold_out: 3 }
  enum mode: { sale: 0, rent: 1 }

  # required fields validations and data integrity

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :direction, presence: true, length: { maximum: 255 }
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :area, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :qty_bedroom, :qty_bathroom, :qty_floor, :qty_kitchen, :qty_parking, :qty_hall,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :office, :shop, :yard, :garden, :social, :is_private, inclusion: { in: [true, false] }

  # conditional validations for property type

  validates :is_private, :qty_bathroom, :qty_bedroom, :qty_parking, :qty_floor, :qty_kitchen, :qty_hall, :office, :shop,
            :yard, :garden, :social, :area, :mode, presence: true, if: :type_house?
  validates :is_private, :qty_bathroom, :qty_bedroom, :qty_parking, :area, :mode, :social, presence: true,
                                                                                           if: :type_apartament?
  validates :is_private, :qty_bathroom, :qty_bedroom, :qty_parking, :area, :mode, presence: true,
                                                                                  if: :type_annex?
  validates :is_private, :qty_bathroom, :qty_floor, :area, :office, :mode, presence: true,
                                                                           if: :type_shop?
  validates :is_private, :qty_bathroom, :qty_floor, :area, :office, :shop, :qty_bedroom, :yard, :mode, presence: true,
                                                                                                       if: :type_shed?

  private

  def type_house?
    type == :house
  end

  def type_apartament?
    type == :apartment
  end

  def type_annex?
    type == :annex
  end

  def type_shop?
    type == :shop
  end

  def type_shed?
    type == :shed
  end
end
