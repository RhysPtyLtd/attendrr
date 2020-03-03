class DemoController < ApplicationController
  before_action :logged_in_user
  before_action :correct_club

  layout false


  def show
    @people = people_array.map { |person| OpenStruct.new(person) }
    @from = @club.created_at
    @to = Date.today
  end

  private

  def people_array
    [
      {
        "id": 1,
        "full_name": "Julianna Rassmann"
      }, {
        "id": 2,
        "full_name": "Danila Willatt"
      }, {
        "id": 3,
        "full_name": "Cazzie Balsdon"
      }, {
        "id": 4,
        "full_name": "Addy Barlas"
      }, {
        "id": 5,
        "full_name": "Nate Thirwell"
      }, {
        "id": 6,
        "full_name": "Bret Collihole"
      }, {
        "id": 7,
        "full_name": "Nata Leggott"
      }, {
        "id": 8,
        "full_name": "Dinny Kornilyev"
      }, {
        "id": 9,
        "full_name": "Jeanne Collimore"
      }, {
        "id": 10,
        "full_name": "Kurtis Rodden"
      }
    ]
  end
end
