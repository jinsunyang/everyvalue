class ApplicationRecord < ActiveRecord::Base
  #include는 module의 method를 instance method로 추가할 때, extend는 module의 method 를 class method로 추가할 때
  extend ActiveRecordExtension

  self.abstract_class = true
end
