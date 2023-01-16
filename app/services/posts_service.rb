class PostsService
    class << self
        def findPost(post)
            @post = PostsRepository.findPost(post)
        end

        def findComment(comment)
            @comment = PostsRepository.findComment(comment)
        end

        def limitPost(limit)
            @last_post = PostsRepository.limitPost(limit)
        end

        def categoryAll
            @category = PostsRepository.categoryAll
        end

        def category(value)
            @category = PostsRepository.category(value)
        end

        def postByCategory(id)
            @category = PostsRepository.postByCategory(id)
        end

        # def categoryList(name)
        #     PostsRepository.categoryList(name)
        # end

        def listAll(page)
            @posts = PostsRepository.listAll(page)
        end

        def search(search,page)
            @posts = PostsRepository.search(search,page)
        end

        def newPost
            @post = PostsRepository.newPost
        end

        def createPost(post_form,user)
            isSavePost = PostsRepository.createPost(post_form,user)
        end

        def updatePost(post,post_form)
            isUpdatePost = PostsRepository.updatePost(post, post_form)
        end

        def deletePost(post)
            isDeletePost = PostsRepository.deletePost(post)
        end

        def post(user)
            @post = PostsRepository.post(user)
        end

        def newComment
            @comment = PostsRepository.newComment
        end

        def CommentAll(post)
            @comments = PostsRepository.CommentAll(post)
        end

        def createComment(comment)
            isSaveComment = PostsRepository.createComment(comment)
        end

        def deleteComment(comment)
            isDeleteComment = PostsRepository.deleteComment(comment)
        end

        def updateComment(comment,comment_form)
            isUpdateComment = PostsRepository.updateComment(comment, comment_form)
        end
    end
end