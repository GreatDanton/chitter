module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?d=retro"
		image_tag(gravatar_url, alt: user.nickname, class: "gravatar")
	end

	def karma_title(user)
	@karma = user.karma
	if user.admin?
		return "Admin"
	else
	case @karma
    when @karma .. -1
    	return "I suck"
    when 0 .. 49
   		return "Noob"
   	when 50 .. 249
      return "Rookie"
    when 250 .. 499
    	return "Tryhard"
    when 500 .. 999
    	return "No idea"
    when 1000 .. 2499
    	return "Huh"
    when 2500 .. 4999
    	return "Tryhard 2"
    when 5000 .. 9999
    	return "Getting popular"
    when 10000 .. 24999
    	return "Little Troll"
    when 25000 .. 49999
    	return "Troll"
    when 50000 .. 99999
    	return "King of Trolls"
    when 100000 .. @karma
    	return "Godlike Troll"
    end
	end

	end
end
