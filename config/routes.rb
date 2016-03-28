Rails.application.routes.draw do
  get '/' => 'tables#first', as: :first_table
  resources :tables, param: :table_name
  scope 'tables/:table_name' do
    resources :columns, param: :columns_name
    resources :records
  end
end
