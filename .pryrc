if Rails.env.development? || Rails.env.test?
  Pry.config.prompt = Pry::Prompt[:rails]

  if defined?(PryByebug)
    Pry.commands.alias_command 'cont', 'continue'
  end
  # Hit Enter to repeat last command
  Pry::Commands.command /^$/, "repeat last command" do
    pry_instance.run_command Pry.history.to_a.last
  end

  # This introduces the `table` statement
  extend Hirb::Console
end
