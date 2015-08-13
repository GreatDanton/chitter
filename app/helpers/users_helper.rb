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
    when @karma .. -500
        return "I am getting banned"
    when -499 .. -1
    	return "I suck"
    when 0 .. 49
   		return "Noob"
   	when 50 .. 249
      return "Greenhorn"
    when 250 .. 499
    	return "Rookie"
    when 500 .. 999
    	return "Amateur"
    when 1000 .. 2499
    	return "Mud slinger"
    when 2500 .. 4999
    	return "Tryhard"
    when 5000 .. 9999
    	return "Getting popular"
    when 10000 .. 24999
    	return "Little Troll"
    when 25000 .. 49999
    	return "Troll"
    when 50000 .. 99999
    	return "King of Trolls"
    when 100000 .. 999999
    	return "Godlike Troll"
    when 1000000 .. @karma
        return "Beyond Godlike Troll"
    end
	end

	end
end
