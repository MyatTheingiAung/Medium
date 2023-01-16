class AuthRepository
    class << self
        def findUser(email)
            @user = User.find_by(email: email)
        end

        def newUser
            @user = User.new
        end

        def createUser(user_form)
            @user = User.new(user_form)
        end
    end
end