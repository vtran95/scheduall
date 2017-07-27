class EventsController < ApplicationController

    def index
        events = Event.all
        @users_events = []
        events.each do |event|
            if event.user == current_user
                @users_events << event
            end
        end
    end

    def show
        @event = Event.find(params[:id])
    end

    def new
        @event = Event.new
        @users = User.where.not(id: current_user.id)
    end

    def create
        @event = Event.new(event_params)
        @event.user = current_user
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
       
        @guest_index.each do |ind|
            @event.attending_users << User.find(ind)
        end

        if @event.save
            redirect_to event_path(@event)
        else
            render :new
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
        @events_inv = current_user.attending_events.all
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
