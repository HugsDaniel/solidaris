require 'rails_helper'

describe User do
  it "is valid with a category, a start date and an organization" do
    mission = Mission.new(
      category: 'Aaron',
      starting_at: Date.today,
      organization: create(:organization))

      expect(mission).to be_valid
  end

  it "is invalid without a category" do
    mission = Mission.new(category: nil)
    mission.valid?
    expect(mission.errors[:category]).to include("doit être rempli(e)")
  end

  it "is invalid without a start date" do
    mission = Mission.new(starting_at: nil)
    mission.valid?
    expect(mission.errors[:starting_at]).to include("doit être rempli(e)")
  end

  it "is invalid without an organization" do
    mission = Mission.new(organization_id: nil)
    mission.valid?
    expect(mission.errors[:organization]).to include("doit exister")
  end

  let(:mission) { create(:mission) }

  let(:today_mission) { create(:mission, starting_at: Date.today) }
  let(:coming_mission) { create(:mission, starting_at: Date.today + 7) }
  let(:current_mission) { create(:current_mission) }

  let(:recurrent_mission) { create(:mission, recurrent: true) }
  let(:urgent_mission) { create(:mission, end_candidature_date: Date.today + 1) }

  let(:mission_within_time_range) { create(:mission, starting_at: Date.strptime("26.11.2018", '%d.%m.%Y')) }
  let(:mission_outside_time_range) { create(:mission, starting_at: Date.strptime("30.11.2018", '%d.%m.%Y')) }

  describe ".start" do
    context "when 'current'" do
      it "returns the current missions" do
        expect(Mission.start("current")).to eq [current_mission]
        expect(Mission.start("current")).not_to include coming_mission, today_mission
      end
    end

    context "when 'coming'" do
      it "returns the coming missions" do
        expect(Mission.start("coming")).to eq [coming_mission]
        expect(Mission.start("coming")).not_to include today_mission, current_mission
      end
    end

    context "when 'today'" do
      it "returns the day missions" do
        expect(Mission.start("today")).to eq [today_mission]
        expect(Mission.start("today")).not_to include coming_mission, current_mission
      end
    end
  end

  describe ".category" do
    it "returns missions with the given category" do
      expect(Mission.category("Collecte")).to eq [mission]
    end
  end

  describe ".address" do
    it "returns missions with the given address" do
      expect(Mission.address("Nantes")).to eq [mission]
    end
  end

  describe ".recurrency" do
    context "when 'urgent'" do
      it "returns urgent missions" do
        expect(Mission.recurrency("urgent")).to eq [urgent_mission]
      end
    end

    context "when 'ponctuel'" do
      it "returns punctual missions" do
        expect(Mission.recurrency("ponctuel")).to eq [mission, urgent_mission]
      end
    end

    context "when 'recurrent'" do
      it "returns recurrent missions" do
        expect(Mission.recurrency("recurrent")).to eq [recurrent_mission]
      end
    end
  end

  describe ".time_range" do
    it "returns missions within the given time range" do
      time_range = "25.11.2018 au 28.11.2018"

      expect(Mission.time_range(time_range)).to eq [mission_within_time_range]
    end
  end
end
