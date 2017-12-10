Rails.application.routes.draw do
  root to: 'colleges#find_all'

  get "/colleges",                        to: "colleges#find_all"
  get "/colleges/search",                 to: "colleges#search"
  get "/colleges/:college_id",            to: "colleges#find", as: "college"
  get "/colleges/:college_id/employees/search",  to: "employees#search"
end
