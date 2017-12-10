class EmployeeService
  def self.search(params)
    college_id = params[:college_id]
    query = params[:query]

    employee_query = EmployeesIndex.query(
      match: {
        college_id: college_id,
      }
    ).query(
      multi_match: {
        query: query,
        fields: [
          :first_name,
          :last_name,
          :email,
        ],
        fuzziness: "AUTO",
      },
    )

    employee_query.records.compact
  end
end
