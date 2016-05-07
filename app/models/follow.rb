class Follow < ActiveRecord::Base

  belongs_to :subject, foreign_key: :subject_id, class_name: 'User'
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  belongs_to :affinity
  scope :wait_acceptance, -> {where ( 'affinity_id is not null')}
  after_create :create_notification
  after_create :create_post

  def self.follow(subject, follower, affinity)
    Follow.where(:subject_id => subject, :follower_id => follower, :affinity_id => affinity).first_or_create(:subject_id => subject, :follower_id => follower, :affinity_id => affinity)
  end
  def unfollow(follow_id)
    follow_id.destroy
  end
  def create_post
    if self.follower!=self.subject
      post = Post.new
      post.user = self.follower
      post.title = self.follower.first_name+" "+self.follower.last_name
      post.subtitle = "Is now following "+self.subject.first_name+" "+self.subject.first_name
      post.image = self.follower.profile_picture
      post.follower_id = self.subject.id
      post.post_type=2
      post.shared_post=0
      post.save
    end
  end
  def create_notification
    if self.follower != self.subject
    notification = Notification.new
    notification.user = self.subject
    notification.title = self.follower.first_name+" "+self.follower.last_name
    notification.subtitle = "Is now following you"
    notification.image = self.follower.profile_picture
    notification.notification_type = 7
    notification.follower_id = self.follower.id
    notification.save
    end
  end
end
