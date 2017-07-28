class AttendeesController < ApplicationController
    
    def update

        attendee_id = params[:id]
        going = params[:going]

        @attendee = Attendee.find(attendee_id)
        
        if going == "true"
            @attendee.status = "true"
        else
            @attendee.status = "false"
        end

        @attendee.save
        
        redirect_to event_path(@attendee.event)
    end
    
end
