class MerchandiseController < ApplicationController
  include Databasedotcom::Rails::Controller
  
  def index
    @merchandise = Merchandise__c.all
  end
  
  def show
    @merchandise = Merchandise__c.find(params[:id])
  end
  
  def new
    @merchandise = Merchandise__c.new   #"ParentId"=>Account.first.Id
  end

  def create
    merchandise = Merchandise__c.new(params[:merchandise__c])
    merchandise.OwnerId = User.first.Id
    #Account.create Account.coerce_params(params[:account])
    begin
      if (merchandise.save)
        redirect_to(merchandise, :notice => 'Merchandise was successfully created.')
      end
    rescue Databasedotcom::SalesForceError => e
        redirect_to(merchandise_index_path, :notice => "Error creating merchandise: #{e.message}")
    end
  end

  def edit
    @merchandise = Merchandise__c.find(params[:id])
  end

    
  def update
        @merchandise = Merchandise__c.find(params[:id])
        #raise params.inspect
        @merchandise.Name = params[:merchandise__c][:Name]
        @merchandise.Price__c = params[:merchandise__c][:Price__c]
        @merchandise.Quantity__c = params[:merchandise__c][:Quantity__c]
        
        begin
          if (@merchandise.save)
            redirect_to(@merchandise, :notice => 'Merchandise was successfully updated.')
          end
        rescue Databasedotcom::SalesForceError => e
            redirect_to(merchandise_path, :notice => "Error updating merchandise: #{e.message}")
        end
    
    #@merchandise = Merchandise__c.find(params[:id])
    #@merchandise.update_attributes(params[:merchandise])
    #render "show"
  end
  
  
end