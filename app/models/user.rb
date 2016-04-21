class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable,
  :omniauthable, :omniauth_providers => [:facebook]

  has_many :advise_advisors, foreign_key: :advisor_id, class_name: 'Advise', dependent: :delete_all
  has_many :advise_subject, foreign_key: :subject_id, class_name: 'Advise', dependent: :delete_all

  has_many :receives_advise_from, foreign_key: :advise_advisors, class_name: 'User', source: :advisor
  has_many :gives_advice_to, foreign_key: :advise_subject, class_name: 'User', source: :subject

  has_many :follows_followers, foreign_key: :subject_id, class_name: 'Follow',dependent: :destroy
  has_many :follows_following, foreign_key: :follower_id, class_name: 'Follow',dependent: :destroy

  has_many :following, through: :follows_following, class_name: 'User', source: :subject
  has_many :followers, through: :follows_followers, class_name: 'User', source: :follower

  has_many :raw_feed, through: :following, class_name: 'Post', source: :posts

  has_many :following_endorses, through: :following, class_name: 'Endorse', source: :endorses_endorser
  has_many :following_endorsements, through: :following_endorses, class_name: 'Endorsement', source: :endorsement

  has_many :advises, foreign_key: :receives_advice_from, class_name: 'Advise',dependent: :destroy

  has_many :comments


  has_many :endorses_endorser, foreign_key: :subject_id, class_name: 'Endorse'
  has_many :endorses_endorsee, foreign_key: :follower_id, class_name: 'Endorse'

  has_many :endorsees, through: :endorses_endorsee, class_name: 'User', source: :endorser
  has_many :endorsers, through: :endorses_endorser, class_name: 'User', source: :endorsee
  has_many :endorsement_endorsers, through: :endorses_endorser, class_name: 'Endorsement', source: :endorsement
  has_many :endorsement_endorsees, through: :endorses_endorsee, class_name: 'Endorsement', source: :endorsement

  has_many :likes

  has_many :problems

  has_many :posts

  has_many :notifications

  has_attached_file :profile_picture, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/
  after_create :autofollow

  def autofollow
    f = Follow.new
    f.follower_id = current_user
    f.subject_id = current_user
    f.affinity_id = 1
    f.save
  end

  def self.from_omniauth(auth)

    uri = URI.parse(auth.info.image)
        uri.query = 'type=large'

      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|

        user.first_name = auth.extra.raw_info.first_name
        user.last_name = auth.extra.raw_info.last_name
        user.gender = auth.extra.raw_info.gender
        user.profile_picture = open( uri.to_s, allow_redirections: :safe )
        user.provider = auth.provider
        user.uid = auth.uid
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        user.city = auth.info.location
      end
  end

  def search_by_many_attributes(search_query)

     by_first_name = User.joins(:endorsement_endorsers).where(["first_name LIKE ? OR last_name LIKE ? OR city LIKE ? OR country LIKE ? OR name LIKE ?","%#{search_query}%","%#{search_query}%","%#{search_query}%","%#{search_query}%","%#{search_query}%"])
     by_endorsement = Endorsement.where(["","#{search_query}%"]).map{|u| u.id}
     search_results_array = [by_first_name, by_endorsement]

  end

  def return_affinity_level(subject_id)
    u = self.follows_following.where(subject_id: subject_id)
    if u.length < 1
      0
    else
      u.first.affinity_id
    end
  end

  def feed(page, per)
   raw_feed.page(page).per(per)
  end

  # def feed(page, per) #page per parece estar funcionando. Gem kaminari para paginacion
  #   following_ids = "SELECT subject_id FROM follows
  #                    WHERE  follower_id = :user_id"
  #   Post.where("user_id IN (#{following_ids})
  #                    OR user_id = :user_id", user_id: id).page(page).per(per)
  # end

  def notifications_display(page, per) #funciona, falta entender bien como funciona paginacion kaminari
  notifications.page(page).per(per)
  end

  def advises_display(page, per) #funciona, falta entender bien como funciona paginacion kaminari
  advises.page(page).per(per)
  end

  def list_attributes(page, per) #funciona en la consola falta probar paginacion, evaluar poner self.

    # endorsement_ids = "SELECT endorsement_id FROM endorses
    #                     WHERE follower_id = #{user_id}"
    # Endorsement.where("id IN (#{endorsement_ids})").page(page).per(per)

    endorsement_endorsers

end

  def display_following(user_id, page, per)
    following_ids = "SELECT subject_id FROM follows
                     WHERE  follower_id = #{user_id}"

    User.where("id IN (#{following_ids})").page(page).per(per)
  end

   # Follows a user.
  def follow(person_being_followed, current_user, affinity_level)
    f = Follow.new
    f.follower_id = current_user
    f.subject_id = person_being_followed
    f.affinity_id = affinity_level
    f.save

    #follows.create(:subject_id => person_being_followed, :follower_id => follower_person, :affinity_id =>affinity_level)
  end

  # Unfollows a user.
  def unfollow(other_user)
    Follow.find_by(subject_id: other_user.id).destroy
  end

  # Returns true if the current user is following the other user.
  def following?(other_user)
    following.where( id: other_user ).length > 0
  end

  def likes?(post)
    likes.where(post_id: post).length > 0
  end

  def likes_comment?(comment)
    likes.where(comment_id: comment).length > 0
  end

  def edit_user_details(user_id, job_title, company_name)

   u = User.find_by(id: user_id)
   u.job_title = job_title
   u.company_name = company_name
   u.save

  end

  def enable_disable_location
    if self.active_location == false
      self.active_location = true
      self.save
    else
      self.active_location = false
      self.save
    end
  end

  def private_feedback
    self.private_advise = true
    self.save
  end

   def public_feedback
    self.private_advise = false
    self.save
  end

private

# def self.process_uri(uri)
#   require 'open-uri'
#   require 'open_uri_redirections'
#   open(uri, :allow_redirections => :safe) do |r|
#     r.base_uri.to_s
#   end
# end

end
