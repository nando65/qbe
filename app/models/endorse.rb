class Endorse < ActiveRecord::Base


  belongs_to :endorser,foreign_key: :subject_id, class_name: 'User'
  belongs_to :endorsee, foreign_key: :endorsee_id, class_name: 'User'
  belongs_to :user
  belongs_to :endorsement


after_create :create_notification

  def self.endorse(endorser, endorsee, endorsement)

    endorse.endorser = endorser
    endorse.endorsee = endorsee
    endorse.endorsement = endorsement

  end

  def create_post

    post = Post.new
    post.user = self.endorsee
    post.title = self.endorsee.first_name+" "+self.endorser.last_name
    post.subtitle = "Has endorsed "+self.subject+" for "+self.endorsement
    post.image = self.endorser.profile_picture
    post.save

  end

  def create_notifcation

    notification = Notification.new
    notification.user = self.endorsee
    notification.title = self.endorser.first_name+" "+self.endorser.last_name
    notification.subtitle = "Has endorsed you for "+ self.endorsement.name
    notification.image = self.endorser.profile_picture
    notification.type = 4
    notification.save

  end

end
