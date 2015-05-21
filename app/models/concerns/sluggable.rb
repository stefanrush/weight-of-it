module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :slug, presence: true

    before_validation :create_slug

    def create_slug
      return if name.blank?
      new_slug = slug.blank? ? name : slug
      # strip non-alphanumerics and replace spaces/underscores with hyphens
      self.slug = new_slug.downcase.gsub(/\A\s+|[^\w\-\s]+|\s+\z/, '')
                                   .gsub(/[\s\_\-]+/, '-')
    end
  end
end
