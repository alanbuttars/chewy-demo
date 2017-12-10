class EmployeesIndex < Chewy::Index
  settings analysis: {
    analyzer: {
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase'],
      },
    },
  }

  define_type Employee.includes(:college) do
    root do
      field :first_name
      field :last_name
      field :email, analyzer: 'email'
      field :college_id, value: ->(employee) do
        employee.college.id
      end
    end
  end
end
