module Api
    class TweetsController < ApplicationController
     
        before_action :set_tweet, only: [:show, :update, :destroy]
       

      respond_to :json

        def index
            #respond_with Tweet.all 
            @tweet = Tweet.last(50).map do |t|
                {
                    id: t.id,
                    content: t.content,
                    user_id: t.user_id,
                    like_count: t.likes.count,
                    retweets_count: t.retweets.count,
                    created_at: t.created_at
                    
                }
            end
            render json: @tweet
        end

        def show
            respond_with Tweet.find(params[:id])
        end

        def create
            @tweet = Tweet.new(tweet_params)
            
            if @tweet.save
              render json: @tweet
            else
              render json: @tweet.errors
            end
        end

        def update
            respond_with Tweet.update(params[:id], params[:tweet])
        end

        def destroy
            respond_with Tweet.destroy(params[:id])
        end

        def between_dates
            @tweets = Tweet.where(created_at:(params[:fecha1].to_date)..(params[:fecha2].to_date))
            render json: @tweets
        end

        private

        def set_post
            @tweet = Tweet.find(params[:id])
        end

        def tweet_params
            params.require(:tweet).permit(:content, :user_id)
        end
    end
end

