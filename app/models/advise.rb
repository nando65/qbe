class Advise < ActiveRecord::Base

    belongs_to :subject, foreign_key: :subject_id, class_name: 'User'
    belongs_to :advisor, foreign_key: :advisor_id, class_name: 'User'

    #after_create :create_notifcation


    def insert_advise(subject_id, advisor_id, advise_text)

    Advise.create receives_advice_from: subject_id, gives_advice_to: advisor_id, advise: advise_text

    end


  def create_notifcation

    notification = Notification.new
    notification.user = self.subject
    notification.title = self.advisor.first_name+" "+self.advisor.last_name
    notification.subtitle = "Has given you advice"
    notification.image = self.advisor.profile_picture
    notification.type = 2
    notification.save

  end
end
