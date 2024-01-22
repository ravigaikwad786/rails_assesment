class DailyRecordJob
  include Sidekiq::Worker

  def perform
    male_count = $redis.get('male_count').to_i
    female_count = $redis.get('female_count').to_i

    daily_record = DailyRecord.find_or_initialize_by(date: Date.today)
    daily_record.update(
      male_count: male_count,
      female_count: female_count
    )
  end
end
