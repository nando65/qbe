class Post < ActiveRecord::Base

  has_many :comments
  has_many :likes
  belongs_to :user

  has_attached_file :image, styles: { medium: "300x300#", thumb: "100x100#" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

def share_post(post_id)

    post = Post.new
    post.user = post.post_id.user
    post.title = post.post_id.title
    post.subtitle = post.post_id.subtitle
    post.image = post.post_id.image
    post.share=1
    post.person_sharing = self.subject
    post.save
end

end
