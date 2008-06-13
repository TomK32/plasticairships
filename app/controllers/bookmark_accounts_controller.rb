class BookmarkAccountsController < ApplicationController
  def index
    @bookmark_accounts = current_user.bookmark_accounts.find :all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @bookmark_accounts }
    end
  end

  def show
    @bookmark_account = current_user.bookmark_accounts.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @bookmark_account }
    end
  end

  def new
    @bookmark_account = current_user.bookmark_accounts.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @bookmark_account }
    end
  end

  def edit
    @bookmark_account = current_user.bookmark_accounts.find(params[:id])
  end

  def create
    @bookmark_account = current_user.bookmark_accounts.new(params[:bookmark_account])

    respond_to do |format|
      if @bookmark_account.save
        flash[:notice] = 'current_user.bookmark_accounts was successfully created.'
        format.html { render :action => "show" }
        format.xml  { render :xml => @bookmark_account, :status => :created, :location => @bookmark_account }
      else
        flash[:error] = 'current_user.bookmark_accounts couldn\'t be created.'
        format.html { render :action => "new" }
        format.xml  { render :xml => @bookmark_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @bookmark_account = current_user.bookmark_accounts.find(params[:id])

    respond_to do |format|
      if @bookmark_account.update_attributes(params[:bookmark_account])
        flash[:notice] = 'current_user.bookmark_accounts was successfully updated.'
        format.html { render :action => "show" }
        format.xml  { head :ok }
      else
        flash[:error] = 'current_user.bookmark_accounts couldn\'t be updated.'
        format.html { render :action => "edit" }
        format.xml  { render :xml => @bookmark_account.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @bookmark_account = current_user.bookmark_accounts.find(params[:id])
    @bookmark_account.destroy

    respond_to do |format|
      flash[:notice] = 'current_user.bookmark_accounts was destroyed'
      format.html { redirect_to(admin_bookmark_accounts_url) }
      format.xml  { head :ok }
    end
  end
end
