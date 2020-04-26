=begin
    Copyright 2013-2017 Sarosys LLC <http://www.sarosys.com>

    This file is part of the Arachni WebUI project and is subject to
    redistribution and commercial restrictions. Please see the Arachni WebUI
    web site for more information on licensing and terms of use.
=end

class HomeController < ApplicationController

    include ApplicationHelper
    include NavigationHelper

    before_filter :authenticate_user!

# Keyur Coded

    Elements_per_page1=10
    Elements_per_page2=10.0

# Keyur Coded End

    def index
#Keyur Coded
        # @activities    = current_user.activities.page( params[:activities_page] )
        #     .per( HardSettings.activities_pagination_entries ).order( 'id DESC' )
#Keyur Coded End
        @activities    = current_user.activities.page( params[:activities_page] )
            .per( HardSettings.activities_pagination_entries ).order( 'id DESC' )
        @notifications = current_user.notifications.page( params[:notifications_page] )
            .per( HardSettings.notifications_pagination_entries ).order( 'id DESC' )

# Keyur Coded

    # Issues per scans (i)

            @pagei = params.fetch(:issues_per_scan_page,0).to_i

            @currentPageNoi=@pagei + 1

            # @countissues = current_user.issues.all.count
            # newCount2 = (@countissues/Elements_per_page1)
            # @newCounti = (@countissues/Elements_per_page2)

            # if @newCounti/1 != @newCounti.floor
            #     @newCounti=newCount2
            # else
            #     @newCounti=newCount2 + 1
            # end

    # Activities (a)

            @pagea = params.fetch(:activities_page,0).to_i
            @activities = current_user.activities.page( params.fetch(:activities_page,0) ).per( HardSettings.activities_pagination_entries )
                .offset(@pagea*Elements_per_page1).limit(Elements_per_page1)
            @counta = current_user.activities.page( params.fetch(:activities_page,1) ).per( HardSettings.activities_pagination_entries ).all.count
            noOfpagea=(@counta/Elements_per_page1)
            @noOfPagesa=(@counta/Elements_per_page2)

            @currentPageNoa=@pagea+1

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

    # Notifications (n)

            @pagen = params.fetch(:notifications_page,0).to_i
            @notifications = current_user.notifications.page( params[:notifications_page] ).per( HardSettings.notifications_pagination_entries )
                 .offset(@pagen*Elements_per_page1).limit(Elements_per_page1)
            @countn = current_user.notifications.page( params[:notifications_page] ).per( HardSettings.notifications_pagination_entries ).all.count
            noOfpagen = (@countn/Elements_per_page1)
            @noOfPagesn = (@countn/Elements_per_page2)

            @currentPageNon=@pagen + 1
            @countNotifications = current_user.notifications.all.count
            newCount1 = (@countNotifications/Elements_per_page1)
            @newCountn = (@countNotifications/Elements_per_page2)

            if @newCountn/1 != @newCountn.floor
                @newCountn=newCount1
            else
                @newCountn=newCount1+1
            end

# Keyur Coded End

        @issues_per_scan = {}
        current_user.scans.each { |s| @issues_per_scan[s.id] = s.issues.count }

        html_block = if render_partial?
                         proc { render partial: 'dashboard' }
                     end

        respond_to do |format|
            format.html( &html_block )
            format.js {
                if params[:render] == 'activities'
                    render '_activities.js.erb'
                elsif params[:render] == 'notifications'
                    render partial: 'notifications.js.erb'
                end
            }
        end
    end

    def navigation
        respond_to do |format|
            format.html { render partial: 'layouts/navigation' }
        end
    end
end