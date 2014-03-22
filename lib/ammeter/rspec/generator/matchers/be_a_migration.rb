RSpec::Matchers.define :be_a_migration do
  match do |file_path|
    dirname, file_name = File.dirname(file_path), File.basename(file_path)

    # Without this hacky next line we get
    # TypeError: can't convert MatchData into String
    StringIO.new.puts 'hi' if RUBY_VERSION == '1.9.3'

    if file_name.match(/\d+_.*\.rb/)
      migration_file_path = file_path
    else
      migration_file_path = Dir.glob("#{dirname}/[0-9]*_*.rb").grep(/\d+_#{file_name}$/).first
    end
    File.exist?(migration_file_path)
  end
end
