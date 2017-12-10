class EmployeeService
  def self.search(params)
    college_id = params[:college_id]
    query = params[:query]

    employee_query = EmployeesIndex.query(
      match: {
        college_id: college_id,
      }
    ).query(
      bool: {
        should: [
          {
            bool: {
              should: [
                {
                  match: {
                    pty_surename: {
                      query: query,
                    },
                  },
                },
                {
                  match: {
                    pty_surename: {
                      query: query,
                      fuzziness: 1,
                    },
                  },
                },
                {
                  match: {
                    'pty_surename.metaphone' => {
                      query: query,
                    },
                  },
                },
                {
                  match: {
                    'pty_surename.porter' => {
                      query: query,
                    },
                  },
                },
              ],
            },
          },
        ],
      },
    )

    employee_query.records.compact
  end
end
