Chewy.strategy(:atomic) do
  data = YAML.load_file 'config/colleges.yml'
  data.map(&:deep_symbolize_keys).each do |datum|
    labels = datum.delete(:labels)

    college = College.new(datum)
    college.labels << Label.where(code: labels)

    email_domain = (college.alias || college.name).dup
    email_domain.gsub!("University", "")
    email_domain.gsub!(" of ", "")
    email_domain.gsub!(/\W/, "")

    10.times do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      email = "#{first_name}.#{last_name}@#{email_domain}.edu".downcase
      employee = Employee.new(
        first_name: first_name,
        last_name: last_name,
        email: email,
      )
      college.employees << employee
    end

    college.save!
  end
end
