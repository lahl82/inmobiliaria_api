# app/views/categories/show.json.jbuilder
json.id @user_session.id
json.email @user_session.email
json.role @user_session.role
json.created_at @user_session.created_at
json.created_date @user_session.created_at&.strftime('%m/%d/%Y')
