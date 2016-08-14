class Message < ApplicationRecord

  after_create_commit { reload_demo }
  after_create_commit { notify }

  private

  def notify
    Notification.create(event: "New Notification (#{self.body})")
  end

  # For demo purposes, clearing up notifications if there are too much of them
  def reload_demo(max=20)
    Message.destroy_all if Message.count >= max
    Notification.destroy_all if Notification.count >= max
  end

end