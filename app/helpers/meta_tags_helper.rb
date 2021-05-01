# frozen_string_literal: true

module MetaTagsHelper
  def default_meta_tags
    {
      site: "SoundLinks",
      reverse: true,
      charset: "utf-8",
      description: "",
      viewport: '"width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0", name: "viewport',
    }
  end
end
