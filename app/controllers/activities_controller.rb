class ActivitiesController < ApplicationController
    
    include ApplicationHelper
    include NavigationHelper

    before_filter :authenticate_user!

# Keyur Coded

    Elements_per_page1=10
    Elements_per_page2=10.0

# Keyur Coded End

    def index
        @activities    = current_user.activities.page( params[:activities_page] )
            .per( HardSettings.activities_pagination_entries ).order( 'id DESC' )

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