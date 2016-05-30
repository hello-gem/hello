require 'spec_helper'

describe Hello::Encryptors::MD5 do

  describe '#encrypt' do
    it('does not work with nil') { expect { subject.encrypt(nil).length }.to raise_error(TypeError) }
    it('works with ""')    { expect(subject.encrypt('').length   ).to eq(32) }
    it('works with "abc"') { expect(subject.encrypt('abc').length).to eq(32) }
  end

  describe '#match' do
    def enc(s)
      subject.encrypt(s)
    end

    it('works with ""')    { digest = enc('');    expect(subject.match('',    digest))  }
    it('works with "abc"') { digest = enc('abc'); expect(subject.match('abc', digest)) }
  end

end # describe
