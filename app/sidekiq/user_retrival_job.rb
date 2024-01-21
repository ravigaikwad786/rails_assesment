class UserRetrivalJob
  include Sidekiq::Job

  def perform(*args)
    response = HTTParty.get('https://randomuser.me/api/?results=20')
    results = response['results']
    results.each do |user_data|
      update_or_create_user(user_data)
    end

    store_gender_counts(results)
  end

  private

  def update_or_create_user(user_data)
    user = User.find_or_initialize_by(uuid: user_data['login']['uuid'])

    user.update(
      gender: user_data['gender'],
      name: user_data['name'],
      location: user_data['location']
    )

    user.save!
  end

  def store_gender_counts(results)

    male_count = results.count { |user| user['gender'] == 'male' }
    female_count = results.count { |user| user['gender'] == 'female' }
    $redis.set('male_count', male_count)
    $redis.set('female_count', female_count)
  end
end
