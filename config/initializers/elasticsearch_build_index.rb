Consultant.__elasticsearch__.create_index! force: true
Consultant.import if Consultant.count > 0
Consultant.__elasticsearch__.refresh_index!
