require 'spec_helper'

describe Peep do

  context 'Demonstration of how datamapper works' do

    it 'should be created and then retrieved from the db' do
      expect(Peep.count).to eq(0)
      Peep.create(name: 'Bibiana Cristòfol Amat',
                  user_name: 'BibsBcn')
      expect(Peep.count).to eq(1)
      peep = Peep.first
      expect(peep.name).to eq('Bibiana Cristòfol Amat')
      expect(peep.user_name).to eq('BibsBcn')
      peep.destroy
      expect(Peep.count).to eq(0)
    end

  end

end