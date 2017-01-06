class Ride < ActiveRecord::Base
  belongs_to :attraction
  belongs_to :user

  def take_ride
    if not_enough_tickets? && not_tall_enough?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}. You are not tall enough to ride the #{self.attraction.name}."
    elsif not_enough_tickets?
      "Sorry. You do not have enough tickets to ride the #{self.attraction.name}."
    elsif not_tall_enough?
      "Sorry. You are not tall enough to ride the #{self.attraction.name}."
    else
      update_user_stats
      "Thanks for riding the #{self.attraction.name}!"
    end
  end

  def not_enough_tickets?
    self.user.tickets < self.attraction.tickets
  end

  def not_tall_enough?
    self.user.height < self.attraction.min_height
  end

  def update_user_stats
    new_tickets = self.user.tickets - self.attraction.tickets
    self.user.update(tickets: new_tickets)

    new_nausea = self.user.nausea + self.attraction.nausea_rating
    self.user.update(nausea: new_nausea)

    new_happiness = self.user.happiness + self.attraction.happiness_rating
    self.user.update(happiness: new_happiness)

  end
end
