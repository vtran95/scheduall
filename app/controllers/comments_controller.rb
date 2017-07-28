class CommentsController < ApplicationController

    def create
        @comment = Comment.new(params.require(:comment).permit(:content, :event_id))
        @comment.user = current_user

        if @comment.content && @comment.content != ''
            @comment.save
        else
            flash[:alert] = "You must write something to post a comment"
        end

        redirect_back(fallback_location: root_path)
    end

    def edit

    end

    def update
    end

    def destroy
        @comment = Comment.find(params[:id])
        event = @comment.event_id
        @comment.destroy
        redirect_to event_path(event)
    end

end
