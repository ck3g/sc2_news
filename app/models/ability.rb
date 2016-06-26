class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end

    user ||= User.new
    cannot :all, :all
    can :manage, [Comment], user_id: user.id
    can :manage, Team, leader_id: user.id
    can [:manage, :accept, :reject], Invite
    can :read, Page

    if user.admin?
      can :manage, :all

    elsif user.editor?
      can :manage, [Article, Tag, Comment, Page, OurFriend]
      can :access, :ckeditor
      can :manage, [Ckeditor::Picture, Ckeditor::AttachmentFile]
      can :manage, [Profile], user_id: user.id
      can :all, [ChatMessage]

    elsif user.writer? || user.streamer?
      can :create, Article
      can :manage, Article, Article.not_deleted_or_mine(user.id) do |article|
        article.deleted_and_owned_by?(user) || article.owned_by?(user)
      end
      can :manage, [Profile], user_id: user.id
      can :read, Tag
      can :access, :ckeditor
      can :manage, [Ckeditor::Picture, Ckeditor::AttachmentFile]
      cannot :destroy, [Ckeditor::Picture, Ckeditor::AttachmentFile]

    elsif user.persisted? && !user.banned? # registered user
      can :manage, [Profile], user_id: user.id
      can :read, Tag
      can :read, Article, Article.visible do |article|
        !article.deleted? && article.published?
      end
      can [:index, :show], Team
    else
      # Guest or Banned possibilities
      cannot :create, Comment
      can :read, Tag
      can :read, Article, Article.visible do |article|
        !article.deleted? && article.published?
      end

      cannot :manage, Team
      can [:index, :show], Team
      cannot [:manage, :accept, :reject], Invite
    end

    #
    # The first argument to `can` is the action you are giving the user permission to do.
    # If you pass :manage it will apply to every action. Other common actions here are
    # :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. If you pass
    # :all it will apply to every resource. Otherwise pass a Ruby class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details: https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
