# app/views/categories/show.json.jbuilder
json.id @user.id
json.email @user.email
json.role @user.role
json.created_at @user.created_at
json.created_date @user.created_at&.strftime('%m/%d/%Y')
