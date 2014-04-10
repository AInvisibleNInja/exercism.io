module ExercismAPI
  module Routes
    class Stats < Core
      get '/stats/:username/nitpicks/:year/:month' do |username, year, month|
        Stats::NitStreak.for(username, year.to_i, month.to_i).to_json
      end

      get '/stats/:username/submissions/:year/:month' do |username, year, month|
        Stats::SubmissionStreak.for(username, year.to_i, month.to_i).to_json
      end

      get '/stats/:username/snapshot' do |username|
        user = User.find_by_username(username)
        if !user
          halt 400, {error: "Unknown user #{username}"}
        end
        snapshot = ::Stats::Snapshot.new(user)
        pg :"stats/snapshot", locals: {snapshot: snapshot}
      end
    end
  end
end
