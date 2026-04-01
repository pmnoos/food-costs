module ApplicationHelper
	def image_source(attachment, variant_name = nil)
		return attachment unless attachment&.attached?

		use_variants = Rails.configuration.x.active_storage_use_variants
		return attachment unless use_variants && variant_name.present?

		attachment.variant(variant_name)
	end
end
