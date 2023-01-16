class PostsRepository
    class << self
        def findPost(post)
            @post = Post.find(post)
        end

        def findComment(comment)
            @comment = Comment.find(comment)
        end

        def limitPost(limit)
            @last_post = Post.order("id DESC").first(limit)
        end

        def categoryAll
            @categories = Category.all
        end

        def category(value)
            @category = Category.where(name: value).first
        end

        def postByCategory(id)
            @posts = Post.where(category_id: id).all
        end

        # def categoryList(name)
        #     @categories = Category.all
        #     @category = Category.where(name: name).first
        #     @posts = Post.where(category_id: @category.id).all
        # end

        def listAll(page)
            @posts = Post.order("id DESC").page(page)
        end

        def search(search,page)
            @posts = Post.where(["title LIKE ?","%#{search}%"]).page(page)
        end
        
        def newPost
            @post = Post.new  
        end

        def createPost(post_form, user)
            @post = Post.new(post_form)
        end

        def updatePost(post,post_form)
            isUpdatePost = post.update(post_form)
        end

        def deletePost(post)
            post.destroy
        end

        def post(user)
            @posts = Post.where(user_id: user)
        end

        def newComment
            @comment = Comment.new
        end

        def CommentAll(post)
            @comments = Comment.order("id DESC").where(post_id: post).where(parent_id: nil)
        end

        def createComment(comment)
            @comment = Comment.new(comment)
        end

        def deleteComment(comment)
            comment.destroy
        end

        def updateComment(comment,comment_form)
            isUpdateComment = comment.update(comment_form)
        end
    end
end