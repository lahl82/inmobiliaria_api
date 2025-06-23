class UserSessionBlueprint < Blueprinter::Base
  identifier :id

  view :default do
    fields :email, :roles, :created_at

    field :created_date do |user, _opts|
      user.created_at&.strftime('%m/%d/%Y')
    end
  end

  view :login do
    include_view :default

    fields :name, :last_name
    association :company, blueprint: CompanyBlueprint, view: :minimal
  end
end
