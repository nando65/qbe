class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  has_many :advise_advisors, foreign_key: :advisor_id, class_name: 'Advise', dependent: :delete_all
  has_many :advise_subject, foreign_key: :subject_id, class_name: 'Advise', dependent: :delete_all

  has_many :receives_advise_from, foreign_key: :advise_advisors, class_name: 'User', source: :advisor
  has_many :gives_advice_to, foreign_key: :advise_subject, class_name: 'User', source: :subject

  has_many :follows_followers, foreign_key: :subject_id, class_name: 'Follow'
  has_many :follows_following, foreign_key: :follower_id, class_name: 'Follow',dependent: :destroy


  has_many :follows
  has_many :following, through: :follows, source: :subject #, class_name: 'User', source: :subject
  has_many :followers, through: :follows_following, class_name: 'User', source: :follower

  has_many :raw_feed, through: :following, class_name: 'Post', source: :posts

  has_many :advises

  has_many :comments


  has_many :endorses_endorser, foreign_key: :subject_id, class_name: 'Endorse'
  has_many :endorses_endorsee, foreign_key: :endorsee_id, class_name: 'Endorse'

  has_many :gives_endorsements_to, foreign_key: :endorses_endorser, class_name: 'User', source: :endorser
  has_many :receives_endorsements_from, foreign_key: :endoreses_endorsee, class_name: 'User', source: :endorsee

  has_many :likes

  has_many :problems

  has_many :posts

  has_many :notifications

  has_attached_file :profile_picture, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :profile_picture, content_type: /\Aimage\/.*\Z/

  def feed(page, per)
    self.raw_feed.page(page).per(per)
  end

  def display_advise (page, per)
    self.advise.per(per).page(page)
  end

  def display_map
    self.following.city (elasticsearch)
  end

  def edit_user_details(job_title, company_name,image)

    user.job_title = job_title
    user.company_name = company_name
    user.image = image

  end

  def search_map
      elasticsearch
  end


  def enable_disable_location
    if self.active_location == false
      self.active_location = true
    else
      self.active_location = false
    end
  end

  def private_feedback
    self.advise.public_access = false
  end

   def public_feedback
    self.advise.public_access = true
  end

  def list_attributes
    self.following.endorsement
    self.following.endorsement(count)
    self.following.following.endorsement
    self.following.following.endorsement(count)
  end

  def list_users_filtered(endorsement)
    self.endorsement.following
    self.endorsement.following.following
  end


  def display_virtue_list_and_values(subject_id)
    subject_id.endorsement
    subject_id.endorsement.value
  end

end
