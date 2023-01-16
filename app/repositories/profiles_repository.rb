class ProfilesRepository
    class << self
        def findUser(user)
            @usre = User::find(user)
        end

        def findPost(user,page)
            @posts = Post.where(user_id: user).page(page)
        end

        def updateProfile(user,profile_form)
            user.update(profile_form)
        end

        def userAuthenticate(user,password)
            user.authenticate(password)
        end

        def userImageDelete(user)
            user.image.delete
            user.image_data = nil
            user.save
        end
    end
end