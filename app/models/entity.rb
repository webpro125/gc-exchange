class Entity < ActiveRecord::Base
  belongs_to :consultant
  validates :consultant, presence: true

   enum entity_type: [ :sole_proprietor, :single_member_llc, :c_corp, :s_corp, :partnership, :llc_c_corp, :llc_s_corp, :llc_partnership ]

   EntityTypeLables = {
     sole_proprietor: "Individual/Sole Proprietor",
     single_member_llc: "Single member Limited Liability Company",
     c_corp: "C Corporation",
     s_corp: "S Corporation",
     partnership: "Partnership",
     llc_c_corp: "Limited Liability Company - C Corporation",
     llc_s_corp: "Limited Liability Company - S Corporation",
     llc_partnership: "Limited Liability Company - Partnership",
   }

   def self.entity_type_select_options
     entity_types.collect {|k, v| [EntityTypeLables[k.to_sym], k] }
   end

   def full_address
     "#{address} #{address2} #{city}, #{state}, #{zip}"
   end
end
