class TweetsController < ApplicationController
  def index
    @tweets = Tweet.all.order(tdate: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.tdate = Time.current

    if @tweet.message.blank? || @tweet.message.length > 140
      flash[:alert] = "メッセージは空であってはいけません。また、140文字以下でなければなりません。"
      render :new
    else
      @tweet.save
      redirect_to tweets_path, notice: "ツイートが作成されました！"
    end
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
  end

  def update
    @tweet = Tweet.find(params[:id])
    
    if @tweet.update(tweet_params)
      redirect_to tweets_path, notice: "ツイートが更新されました！"
    else
      render :edit
    end
  end

  def destroy
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect_to tweets_path, notice: "ツイートが削除されました！"
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end
end
