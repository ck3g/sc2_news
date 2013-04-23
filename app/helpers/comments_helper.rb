module CommentsHelper
  def avatar_tag(user)
    if user
      avatar_html user.profile
    else
      image_tag 'avatars/default.gif'
    end
  end

  def link_to_commenter(comment)
    if comment.user
      link_to comment.username, user_profile_path(comment.username)
    else
      "#{ t(:unknown_user) }"
    end
  end

end
