# frozen_string_literal: true

module CodebreakerVk
  class GameMessages
    class << self
      def greeting_msg
        puts I18n.t('console.greeting')
      end

      def goodbye
        puts I18n.t(:goodbye)
      end

      def what_next_text
        puts I18n.t('console.choose_the_command', stats: Console::COMMANDS[:stats], rules: Console::COMMANDS[:rules],
                    start: Console::COMMANDS[:start], exit: Console::COMMANDS[:exit])
      end

      def what_name_msg
        puts I18n.t('console.what_name')
      end

      def select_difficulty_msg
        puts I18n.t('console.select_difficulty', difficulties: Difficulty::DIFFICULTIES.keys.join(', '))
      end

      def make_guess_msg
        puts I18n.t('console.make_guess')
      end

      def showed_hint_msg(showed)
        puts I18n.t('console.showed_hint', showed: showed)
      end

      def zero_hints_msg
        puts I18n.t('console.zero_hints')
      end

      def round_info_text(result, attempts, hints)
        puts I18n.t('console.result', result: result)
        puts I18n.t('console.left_attempts_and_hints', attempts: attempts, hints: hints)
        puts I18n.t('console.make_guess')
        puts I18n.t('console.enter_hint') if hints.positive?
      end

      def win_msg
        puts I18n.t('console.win', yes: Console::ACCEPT_SAVING_RESULT)
      end

      def lose_msg
        puts I18n.t('console.lose')
      end

      def empty_db_msg
        puts I18n.t('console.empty_db')
      end

      def show_db(loaded_db)
        sort_db(loaded_db).each_with_index do |user, index|
          puts I18n.t('console.stats_user_info', position: index + 1, name: user[:name], level: user[:level])
          puts I18n.t('console.stats_lefts', attempts: user[:left_attempts], all_attempts: user[:all_attempts],
                      hints: user[:left_hints], all_hints: user[:all_hints])
        end
      end

      def show_rules
        puts I18n.t('console.rules')
      end

      def error_msg(error)
        puts I18n.t('error', error: error)
      end

      def sort_db(loaded_db)
        loaded_db.sort_by { |user| [user[:all_attempts], -user[:left_attempts], -user[:left_hints]] }
      end
    end
  end
end
