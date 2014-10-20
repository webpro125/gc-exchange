require 'spec_helper'

describe ApprovedStatus do
  it_behaves_like 'lookup'

  subject do
    ApprovedStatus.new(code: 'NEW_STATUS')
  end
end
