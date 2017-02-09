class FavoriteMailer < ApplicationMailer
    default from: "sam.x.wu@gmail.com"
    default cc: "madden.rob@gmail.com"
    
    def new_comment(user, post, comment)
 
     headers["Message-ID"] = "<comments/#{comment.id}@bloccit-wu.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@bloccit-wu.example>"
     headers["References"] = "<post/#{post.id}@bloccit-wu.example>"
 
     @user = user
     @post = post
     @comment = comment
 
     mail(to: user.email, subject: "New comment on #{post.title}")
   end
   
end
