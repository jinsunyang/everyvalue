module BaseUser
  extend ActiveSupport::Concern

  included do
    attr_encoded :id, encoder: 'numeric_36', prefix: 'EV'
  end
end