class Users::ShowSerializer < UserSerializer
  attributes :id, :first_name, :last_name, :email, :phone
end
