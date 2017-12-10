class EmployeesIndex < Chewy::Index

  # Courtesy of Alex Brasetvik (see https://stackoverflow.com/questions/20632042/elasticsearch-searching-for-human-names)
  settings analysis: {
    analyzer: {
      metaphone: {
        type: 'custom',
        tokenizer: 'standard',
        filter: ['my_metaphone'],
      },
      porter: {
        type: 'custom',
        tokenizer: 'standard',
        filter: ['lowercase', 'porter_stem'],
      },
      email: {
        tokenizer: 'keyword',
        filter: ['lowercase'],
      },
    },
    filter: {
      my_metaphone: {
        encoder: 'metaphone',
        replace: false,
        type: 'phonetic',
      },
    },
  }

  define_type Employee.includes(:college) do
    root do
      field :pty_surename, analyzer: 'simple', value: ->(employee) do
        employee.full_name
      end
      field :metaphone, analyzer: 'metaphone', value: ->(employee) do
        employee.full_name
      end
      field :porter, analyzer: 'porter', value: ->(employee) do
        employee.full_name
      end
      field :email, analyzer: 'email'
      field :college_id, value: ->(employee) do
        employee.college.id
      end
    end
  end
end
