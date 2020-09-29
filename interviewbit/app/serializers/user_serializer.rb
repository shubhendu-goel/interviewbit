class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :email , :id
  has_many :interviews
end
