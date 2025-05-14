# app/views/users/registrations/create.json.jbuilder
json.id @user_session.id
json.email @user_session.email
json.roles @user_session.roles
json.created_at @user_session.created_at
json.created_date @user_session.created_at&.strftime('%m/%d/%Y')
