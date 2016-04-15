class Post < ActiveRecord::Base

  has_many :comments
  has_many :likes
  belongs_to :user


  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

def self.share_post(post_id, current_user)

    u=User.find_by(id: current_user)
    new_post =Post.find_by(id: post_id).dup
    new_post.shared_post=1
    new_post.person_sharing = u.first_name+" "+u.last_name
    new_post.person_sharing_id = u.id
    new_post.save

end

end
