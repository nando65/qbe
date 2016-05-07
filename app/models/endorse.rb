class Endorse < ActiveRecord::Base
  belongs_to :endorser,foreign_key: :follower_id, class_name: 'User'
  belongs_to :endorsee, foreign_key: :subject_id, class_name: 'User'
  belongs_to :endorsement
  before_save :set_weight
  validate :no_more_than_five
  after_create :create_notification
  after_create :create_post

def no_more_than_five
   if Endorse.where(:endorser => self.endorser, :endorsee => self.endorsee).count > 4
    self.errors.add(:endorser, 'No puedes endorsar mas de cinco veces a la misma persona')
    puts "Error"
  end
end
def set_weight
  if self.endorser.return_affinity_level(self.endorsee) == 1
  self.weight = 3
  elsif self.endorser.return_affinity_level(self.endorsee) == 2
    self.weight = 2
  elsif self.endorser.return_affinity_level(self.endorsee) ==3
    self.weight = 1
  end
end
def insert_endorse(subject_id, follower_id, endorsement_id)
    Endorse.create subject_id: subject_id, follower_id: follower_id, endorsement_id: endorsement_id
end
def self.endorse(endorser, endorsee, endorsement)

    endorse.endorser = endorser
    endorse.endorsee = endorsee
    endorse.endorsement = endorsement
end
def create_post
    post = Post.new
    post.user = self.endorser
    post.title = self.endorser.first_name+" "+self.endorser.last_name
    post.subtitle = "Has endorsed "+self.endorsee.first_name+" "+self.endorsee.last_name+" for "+ self.endorsement.name
    post.image = self.endorser.profile_picture
    post.follower_id = self.endorsee.id
    post.post_type=1
    post.save
end
def create_notification
    notification = Notification.new
    notification.user = self.endorsee
    notification.title = self.endorser.first_name+" "+self.endorser.last_name
    notification.subtitle = "Has endorsed you for "+ self.endorsement.name
    notification.image = self.endorser.profile_picture
    notification.notification_type = 4
    notification.endorse_weight = self.set_weight
    notification.follower_id = self.endorser.id
    notification.save
  end


end