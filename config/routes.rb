Rails.application.routes.draw do
  get '/' => 'tables#first', as: :first_table
  resources :tables, param: :table_name, except: [:index, :new, :edit]
  scope 'tables/:table_name' do
    resources :columns, param: :columns_name, only: [:create, :update, :destroy]
    resources :records, only: [:create, :update, :destroy]
  end
end
