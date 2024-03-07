# app/views/categories/show.json.jbuilder
json.id @user_session.id
json.name @user_session.name
json.last_name @user_session.last_name
json.email @user_session.email
# json.token "Bearer #{@token_session}"
