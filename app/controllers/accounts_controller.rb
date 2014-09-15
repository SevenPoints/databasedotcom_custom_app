class AccountsController < ApplicationController
  include Databasedotcom::Rails::Controller
    
  def index
    @accounts = Account.all
  end

  def show
    @account = Account.find(params[:id])
  end

  def new
    @account = Account.new   #"ParentId"=>Account.first.Id
  end
  
  def create
      account=Account.new(params[:account])
      account.OwnerId=User.first.Id
      account.Med_Consult_Requested__c=false
      #Account.create Account.coerce_params(params[:account])
      begin
        if (account.save)
          redirect_to(account, :notice => 'Account was successfully created.')
        end
      rescue Databasedotcom::SalesForceError => e
          redirect_to(accounts_path, :notice => "Error creating account: #{e.message}")
      end
  end

  def edit
    @account = Account.find(params[:id])
  end
  
  def update
    @account = Account.find(params[:id])
    @account.update_attributes(params[:account])
    render "show"
  end  
  
  
  
end
