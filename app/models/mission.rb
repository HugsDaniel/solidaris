class Mission < ApplicationRecord
  belongs_to :organization

  has_many :applications
  has_many :users, through: :applications

  validates :category, :starting_at, presence: true

  scope :category, -> category { where("category ILIKE ?", category) unless category == "categories" }
  scope :address, -> city { where("address ILIKE ?", "%#{city}%") }
  scope :recurrency, -> recurrency { scope_recurrency(recurrency) }
  scope :time_range, -> time_range { scope_time_range(time_range) }
  scope :start, -> start { scope_start(start) }
  scope :today, -> { where(starting_at: Date.today) }
  scope :coming, -> { where('starting_at > ?', Date.current) }
  scope :current, -> do
    where("recurrent = ? AND starting_at < ? AND recurrency_ending_on > ?", true, Date.current, Date.current)
  end



  extend Enumerize
  enumerize :categories, in: [
    :Hebergement,
    :Activite,
    :Collecte,
    :Accompagnement,
    :Evenement,
    :Maraude,
    :Enseignement,
    :Sante
  ]

  def self.scope_recurrency(recurrency)
    return unless recurrency.present? and recurrency != "both"
    case recurrency
    when "recurrent"
      where(recurrent: true)
    when "ponctuel"
      where(recurrent: false)
    when "urgent"
      where(recurrent: "false", end_candidature_date: Date.today..(Date.today + 7))
    end
  end

  def self.scope_time_range(time_range)
    return unless time_range.present?
    starting_on, ending_on = time_range.split(' au ')

    starting_on = Date.strptime(starting_on, '%d.%m.%Y')
    ending_on = Date.strptime(ending_on, '%d.%m.%Y')

    where("date(starting_at) BETWEEN ? AND ?", starting_on, ending_on)
  end

  def self.scope_start(start)
    case start
    when "today"
      today
    when "coming"
      coming
    when "current"
      current
    end
  end
end
