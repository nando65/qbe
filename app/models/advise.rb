class Advise < ActiveRecord::Base

    belongs_to :subject, foreign_key: :subject_id, class_name: 'User'
    belongs_to :advisor, foreign_key: :advisor_id, class_name: 'User'

    after_create :create_notifcation


    def self.advise(subject, advisor, advice)

        advise.subject = subject
        advise.advisor = advisor
        advise.advice = advice
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
