require 'spec_helper'

describe Hello::Encryption::Encryptor do

  describe '#encrypt' do
    def use_bcrypt
      start_with('$2a$04$')
    end

    it('works with nil')   { expect(subject.encrypt(nil)).to   use_bcrypt }
    it('works with ""')    { expect(subject.encrypt('')).to    use_bcrypt }
    it('works with "abc"') { expect(subject.encrypt('abc')).to use_bcrypt }
  end

  describe '#match' do
    def enc(s)
      subject.encrypt(s)
    end

    it('works with nil')   { digest = enc(nil);   expect(subject.match(nil,   digest))  }
    it('works with ""')    { digest = enc('');    expect(subject.match('',    digest))  }
    it('works with "abc"') { digest = enc('abc'); expect(subject.match('abc', digest)) }
  end

end # describe
