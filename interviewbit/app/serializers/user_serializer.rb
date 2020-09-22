class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email
  has_and_belongs_to_many :interviews
end
