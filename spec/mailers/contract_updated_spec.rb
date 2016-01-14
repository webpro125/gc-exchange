require "spec_helper"

describe ContractUpdated do
  describe "notify" do
    let(:consultant){ create(:consultant) }
    let(:mail) { ContractUpdated.notify(consultant) }

    it "renders the headers" do
      mail.subject.should eq("Recently Updated Contract on GCES")
      mail.to.should eq([consultant.email])
    end

    it "renders the body" do
      mail.body.encoded.should match("recently made updates to our contract")
    end
  end

end
