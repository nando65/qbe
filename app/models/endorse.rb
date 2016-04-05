class Endorse < ActiveRecord::Base


  belongs_to :endorser,foreign_key: :follower_id, class_name: 'User'
  belongs_to :endorsee, foreign_key: :subject_id, class_name: 'User'
  belongs_to :endorsement
  before_save :set_weight
  validate :no_more_than_five

  def no_more_than_five
   if Endorse.where(:endorser => self.endorser, :endorsee => self.endorsee).count > 4

    self.errors.add(:endorser, 'No puedes endorsar mas de cinco veces a la misma persona')
    puts "Error"
  end

  end

def set_weight

  self.weight = self.endorser.return_affinity_level(self.endorsee)

end

#after_create :create_notification

def list_attributes(user_id, page, per) #funciona en la consola falta probar paginacion, evaluar poner self.

    # endorsement_ids = "SELECT endorsement_id FROM endorses
    #                     WHERE follower_id = #{user_id}"
    # Endorsement.where("id IN (#{endorsement_ids})").page(page).per(per)

    u = User.find user_id

    u.following_endorsements

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
