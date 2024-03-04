# app/views/categories/show.json.jbuilder
json.id @user.id
json.name @user.name
json.last_name @user.last_name
json.email @user.email
# json.token "Bearer #{@token}"
