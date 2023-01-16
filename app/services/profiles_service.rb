class ProfilesService
    class << self
        def findUser(user)
            @user = ProfilesRepository.findUser(user)
        end

        def findPost(user,page)
            @post = ProfilesRepository.findPost(user,page)
        end

        def updateProfile(user,profile_form)
            isUpdateProfile = ProfilesRepository.updateProfile(user,profile_form)
        end

        def userAuthenticate(user,password)
            isAuthenticate = ProfilesRepository.userAuthenticate(user,password)
        end

        def userImageDelete(user)
            userImageDelete = ProfilesRepository.userImageDelete(user)
        end
    end
end