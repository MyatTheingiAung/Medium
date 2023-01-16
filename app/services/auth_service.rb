class AuthService
    class << self
        def findUser(email)
            @user = AuthRepository.findUser(email)
        end

        def newUser
            @user = AuthRepository.newUser
        end

        def createUser(user_form)
            @user = AuthRepository.createUser(user_form)
        end
    end
end