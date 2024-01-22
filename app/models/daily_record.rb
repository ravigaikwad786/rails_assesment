class DailyRecord < ApplicationRecord
  include ActiveRecord::AttributeMethods::Dirty

  after_save :calculate_and_update_averages, if: -> { attribute_changed?('male_count') || attribute_changed?('female_count') }

  private

  def calculate_and_update_averages
  	byebug
    total_male_age = User.where(gender: 'male').sum(:age)
    total_female_age = User.where(gender: 'female').sum(:age)

    total_male_count = User.where(gender: 'male').count
    total_female_count = User.where(gender: 'female').count

    male_avg_age = total_male_count.zero? ? 0 : total_male_age.to_f / total_male_count
    female_avg_age = total_female_count.zero? ? 0 : total_female_age.to_f / total_female_count

    update(
      male_avg_age: male_avg_age.round(2),
      female_avg_age: female_avg_age.round(2)
    )
  end
end
