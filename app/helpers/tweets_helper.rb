module TweetsHelper
	def get_tagged(tweet)
		message_arr = Array.new   #holds each word of tweet
		
		message_arr = tweet.message.split

    	message_arr.each_with_index do |word, index|
	      	if word[0] == "#"
		        if Tag.pluck(:phrase).include?(word.downcase)
		          tag = Tag.find_by(phrase: word.downcase)
		          #save that Tag as a variable (to use in TweetTag creation)
		        else
		          tag = Tag.create(phrase: word.downcase)
		          #create a new instance of Tag
		        end #ends if/else
		        tweet_tag = TweetTag.create(tweet_id: @tweet.id, tag_id: tag.id)
		        message_arr[index] = "<a href='/tag_tweets?id=#{tag.id}'>#{word}</a>"
	     	end  #ends if
     	end #ends message_arr .each loop  

    	
    	tweet.message = message_arr.join(" ")
    	return tweet
    end	
end
