require 'inch_ci/action'

module Action
  module User
    class Show
      include InchCI::Action

      exposes :user, :projects, :languages

      def initialize(current_user, params)
        if user = find_user(params)
          @user = UserPresenter.new(user)
          @projects = find_projects(@user) #.map { |p| ProjectPresenter.new(p) }
          @languages = ['Ruby', 'Elixir']
        else
          raise "Not found: #{params}"
        end
      end

      private

      def find_user(params)
        InchCI::Store::FindUser.call(params[:service], params[:user])
      end

      def find_projects(user)
        InchCI::Store::FindAllProjects.call(user)
      end
    end
  end
end
