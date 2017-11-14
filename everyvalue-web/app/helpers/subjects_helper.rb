module SubjectsHelper
  def hashtags_options
    Hashtag.all
    # Hashtag.all.map(&:name)
  end
end
