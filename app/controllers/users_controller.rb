=begin
    Copyright 2013-2017 Sarosys LLC <http://www.sarosys.com>

    This file is part of the Arachni WebUI project and is subject to
    redistribution and commercial restrictions. Please see the Arachni WebUI
    web site for more information on licensing and terms of use.
=end

class UsersController < ApplicationController
    before_filter :authenticate_user!
    before_filter :new_user, only: [ :create ]

    load_and_authorize_resource

# Keyur Coded

    Elements_per_page1=10
    Elements_per_page2=10.0

# Keyur Coded End

    def index
        #@users = User.order( 'id desc' ).all
        #@users = User.order( 'id desc' ).page(params[:page])

# Keyur Coded

        @page=params.fetch(:page,0).to_i

        @users = User.offset(@page*Elements_per_page1).limit(Elements_per_page1)
        @count = User.all.count
        noOfpage = (@count/Elements_per_page1)
        @noOfPages = (@count/Elements_per_page2)

        #@noOfPages=@noOfPages.ceil

        puts @noOfPages

        if @noOfPages/1 != @noOfPages.floor
            @noOfPages = noOfpage
        else
            @noOfPages = noOfpage-1
        end
        @currentPageNo = @page+1
        if @page<1
            @disabledPrev = true
        else
            @disabledPrev = false
        end

        if @page>@noOfPages-1
            @disabledNext = true
        else
            @disabledNext = false
        end

        #@lastNoOfPages=(@count/Elements_per_page).floor

#Keyur Coded End

    end

    def show
        @user       = User.find( params.require( :id ) )
        @scans      = @user.own_scans.limit(Elements_per_page1).select { |s| can? :read, s }
                        # .offset(@countb*Elements_per_page1)

        # @scansoff   = @scans.offset(@scanpagef*Elements_per_page1)

        @activities = @user.activities.page( params[:activities_page] ).
                        per( HardSettings.activities_pagination_entries ).
                        order( 'id DESC' )

# Keyur Coded

    # Activities (a)

            @pagea = params.fetch(:activities_page,0).to_i
            @activities = current_user.activities.page( params.fetch(:activities_page,0) ).per( HardSettings.activities_pagination_entries )
                .offset(@pagea*Elements_per_page1).limit(Elements_per_page1)
            @counta = current_user.activities.page( params.fetch(:activities_page,1) ).per( HardSettings.activities_pagination_entries ).all.count
            noOfpagea = (@counta/Elements_per_page1)
            @noOfPagesa=(@counta/Elements_per_page2)

            @currentPageNoa = @pagea+1
            @currentPageNoua = @pagea+1

            @countb = current_user.activities.all.count

            newCount = (@countb/Elements_per_page1)
            @newCounta = (@countb/Elements_per_page2)

            @a=@pagea-1
            @z=@pagea+1

            if @newCounta/1 != @newCounta.floor
                @newCounta=newCount
            else
                @newCounta=newCount+1
            end

    #finished (f)
            
            @scanpagef = params.fetch(:scan_page,1).to_i
            @currentPageNof = @scanpagef
            @scanFinCount = (@scans.size).to_f
            newCount = (@scanFinCount/10).to_i
            @newCountFin = (@scanFinCount/10.0).to_f

            @countsc = current_user.scans.all.count

        #lastpage logic

            if @newCountFin != newCount
                @newCountFin1 = newCount+1
            else
                @newCountFin1 = newCount
            end

        # nextpage logic

            if @scanpagef != @newCountFin1
                @positive = @scanpagef+1
            else
                @positive = @scanpagef
            end

        # prevpage logic

            if @scanpagef < 1
                @scanpagef = 1
            end

            if @currentPageNof > 1
                @negative = @scanpagef-1
            else
                @negative = @scanpagef
            end

# Keyur Coded End

    end

    def new
        @user = User.new

        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @user }
        end
    end

    def edit
        @user = User.find( params.require( :id ) )
    end

    def create
        respond_to do |format|
            if @user.save
                format.html { redirect_to @user, notice: 'User was successfully created.' }
                format.json { render json: @user, status: :created, location: @user }
            else
                format.html { render action: "new" }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        @user = User.find( params.require( :id ) )

        respond_to do |format|
            if @user.update_attributes( strong_params )
                format.html { redirect_to :back, notice: 'User was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @user.errors, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @user = User.find( params.require( :id ) )

        @user.destroy

        respond_to do |format|
            format.html { redirect_to users_url }
            format.json { head :no_content }
        end
    end

    private

    def new_user
        @user = User.new( strong_params )
    end

    def strong_params
        if params[:user][:password].blank?
            params[:user].delete(:password)
            params[:user].delete(:password_confirmation)
        end

        if current_user.admin?
            params.require( :user ).
                permit( :name, :email, :password, :password_confirmation,
                        :remember_me, { role_ids: [] } )
        else
            params.require( :user ).
                permit( :name, :email, :password, :password_confirmation,
                        :remember_me )
        end
    end

end