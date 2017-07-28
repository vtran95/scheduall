class EventsController < ApplicationController

    def index
        @users_events = current_user.events.order('events.start_date ASC')
    end

    def show
        @event = Event.find(params[:id])
        @users = User.all
        @comments = @event.comments.order('comments.created_at DESC')
        @comment = Comment.new(event_id: @event.id)
    end

    def new
        @event = Event.new
        @users = User.where.not(id: current_user.id)
    end

    def create
        @event = Event.new(event_params)
        @event.user = current_user
        @event.start_date = fix_date(:start_date)

        @guest_index = []
        params.each do |key, val|
            if val == "true"
                @guest_index << key.to_i
            end
        end
    
        @guest_index.each do |ind|
            @event.attending_users << User.find(ind)
        end

        if params[:event][:end_date] && params[:event][:end_date] != ''
            @event.end_date = fix_date(:end_date)
            unless @event.end_date < @event.start_date
                if @event.save
                    redirect_to event_path(@event)
                else
                    flash[:alert] = "Event could not be created, check that event title and start date has been filled"
                    redirect_to new_event_path
                end
            else
                flash[:alert] = "End date/time must be after start date/time"
                redirect_to new_event_path
            end
        else
            if @event.save
                redirect_to event_path(@event)
            else
                flash[:alert] = "Event could not be created, check that event title and start date has been filled"
                redirect_to new_event_path
            end
        end

    end

    def edit
        @event = Event.find(params[:id])
        @users = User.where.not(id: current_user.id)
    end

    def update
        @event = Event.find(params[:id])

        @event.update_attributes(event_params)
        @event.start_date = fix_date(:start_date)

        if params[:event][:end_date]
            @event.end_date = fix_date(:end_date)
        end

        @guest_index = []
        params.each do |key, val|
            if val == "true"
                @guest_index << key.to_i
            end
        end

        @event.attendees.destroy_all

        @guest_index.each do |ind|
            @event.attending_users << User.find(ind)
        end

        if @event.save
            redirect_to event_path(@event)
        else
            redirect_to edit_event_path
        end
    end

    def destroy
        @event = Event.find(params[:id])
        @event.destroy
        redirect_to events_path
    end

    def invited
        @events_inv = current_user.attending_events.order('events.start_date ASC')
    end

private

    def event_params
        params.require(:event).permit(:title, :description, :start_date, :end_date)
    end

    def fix_date(date)
        datestring = params[:event][date]
        unless datestring == ""
            month = datestring[0..1].to_i
            day = datestring[3..4].to_i
            year = datestring[6..9].to_i

            unless datestring.length < 19
                hour = datestring[11..12].to_i
                minute = datestring[14..15].to_i
                ampm = datestring[17..18]
            else
                hour = datestring[11].to_i
                minute = datestring[13..14].to_i
                ampm = datestring[16..17]
            end
            if hour == 12 && ampm.downcase == "pm"
            
            elsif ampm.downcase == "pm"
                hour += 12;
            elsif ampm.downcase == "am" && hour == 12
                hour -= 12
            end
        
            DateTime.new(year,month,day,hour,minute)
        end

    end

end
