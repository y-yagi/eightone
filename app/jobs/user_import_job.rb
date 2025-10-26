class UserImportJob < ApplicationJob
  include ActiveJob::Continuable

  queue_as :default

  def perform
    @users = 100.times.map do |i|
      { email: "user#{i}+example.com" }
    end

    step :initialize do
      "initialize something"
    end

    step :process, start: 0 do |step|
      @users[step.cursor..].each do |user|
        User.create!(email: user[:email])
        puts "Imported user: #{user[:email]}"
        step.advance!
        sleep 1
      end
    end

    step :finalize
  end


  private
    def finalize
      puts "Imported #{@users.size} users"
    end
end
